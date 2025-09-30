
rm(list=ls())

library(httr)
library(jsonlite)
library(ggplot2)
library(dplyr)
library(lubridate)
library(tidyr)
library(eurostat)

# --------------------------------------
# 1. ELECTRICITY PRICES FROM EUROSTAT
# --------------------------------------
electricity_data <- get_eurostat("nrg_pc_204", time_format = "date")

# Filter for latest data: household electricity prices (medium consumers)
elec_prices <- electricity_data %>%
  filter(tax == "I_TAX", 
         unit == "KWH", 
         nrg_cons == "KWH2500-4999", 
         currency == "EUR") %>%
  group_by(geo) %>%
  filter(TIME_PERIOD == max(TIME_PERIOD)) %>%
  ungroup()

# Add readable country names
elec_prices$country <- label_eurostat(elec_prices$geo, lang = "en")

# --------------------------------------
# 2. EU GAS STORAGE DATA FROM AGSI+
# --------------------------------------
# Note: You'll need a (free) API key from https://agsi.gie.eu
api_key <- "4c32465ba82ab78756bc31d14a765931"

agsi_url <- "https://agsi.gie.eu/api?country=EU&format=json"
response <- GET(agsi_url, add_headers(`x-key` = api_key))
agsi_data <- fromJSON(content(response, "text"), flatten = TRUE)

# Clean and format AGSI data
gas_df <- agsi_data$data %>%
  as.data.frame() %>%
  mutate(date = as.Date(gasDayStarted),
         fullness = as.numeric(storageFull)) %>%
  arrange(date)

# --------------------------------------
# 3. OPTIONAL: WEATHER FOR CONTEXT
# --------------------------------------
weather_url <- "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.4050&daily=temperature_2m_max,temperature_2m_min&timezone=Europe%2FBerlin"
weather_data <- fromJSON(weather_url)
weather_df <- weather_data$daily %>%
  as.data.frame() %>%
  mutate(date = as.Date(time))


# --------------------------------------
# 4. PLOTS
# --------------------------------------

# Electricity prices
ggplot(elec_prices, aes(x = reorder(country, -values), y = values)) +
  geom_col(fill = "#0072B2") +
  coord_flip() +
  labs(title = "EU Household Electricity Prices", subtitle = "EUR per kWh (latest available)",
       x = "", y = "EUR/kWh") +
  theme_minimal()

# Gas storage levels over time
ggplot(gas_df, aes(x = date, y = fullness)) +
  geom_line(color = "#D55E00", size = 1.2) +
  labs(title = "EU Gas Storage Level", subtitle = "Daily total (%)", x = "Date", y = "Storage Fullness (%)") +
  theme_minimal()

# Optional: overlay weather
ggplot(weather_df, aes(x = date)) +
  geom_line(aes(y = temperature_2m_max), color = "firebrick") +
  geom_line(aes(y = temperature_2m_min), color = "steelblue") +
  labs(title = "Daily Max/Min Temperatures in Berlin", y = "Temperature (°C)", x = "Date") +
  theme_minimal()

