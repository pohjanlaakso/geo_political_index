rm(list=ls())

# Load libraries
library(tidyverse)
library(readr)
library(jsonlite)

# List of EU Member States (as of 2025)
eu_countries <- c("Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czech Republic",
                  "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary",
                  "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta",
                  "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia",
                  "Spain", "Sweden")


# Download Parlgov data (once)
download.file("https://parlgov.org/data/parlgov-development_csv-utf-8.zip", destfile = "parlgov.zip")
unzip("parlgov.zip", exdir = "parlgov_data")

# Load datasets
parties <- read_csv("parlgov_data/party.csv")
cabinet <- read_csv("parlgov_data/cabinet.csv")
election <- read_csv("parlgov_data/election.csv")
countries <- read_csv("parlgov_data/country.csv")
results <- read_csv("parlgov_data/election_result.csv")
party_cmp <- read_csv("parlgov_data/external_party_cmp.csv")
party_ray <- read_csv("parlgov_data/external_party_ray.csv")
party_benoit_laver <- read_csv('parlgov_data/external_party_benoit_laver.csv')
party_position <- read_csv('parlgov_data/viewcalc_party_position.csv')
parliament_composition <- read_csv('parlgov_data/viewcalc_parliament_composition.csv')
election_parameter <- read_csv('parlgov_data/viewcalc_election_parameter.csv')
year_share <- read_csv('parlgov_data/viewcalc_country_year_share.csv')

# Step 4: Get numeric country_ids for EU countries
eu_country_ids <- countries %>%
  filter(name %in% eu_countries) %>%
  pull(id)

# Filter to EU countries only
cabinet_eu <- cabinet %>% filter(country_id %in% eu_country_ids)
parties_eu <- parties %>% filter(country_id %in% eu_country_ids)
elections_eu <- election %>% filter(country_id %in% eu_country_ids)

latest_cabinets <- cabinet_eu %>%
  group_by(country_id) %>%
  filter(start_date == max(start_date)) %>%
  ungroup()

latest_cabinets_with_parties <- latest_cabinets %>%
  left_join(parties_eu, by = "id")

latest_elections <- elections_eu %>%
  filter(type_id == "1") %>%
  group_by(country_id) %>%
  filter(date == max(date)) %>%
  ungroup()

seats_by_party <- latest_elections %>%
  select(country_id, id) %>%
  left_join(results, by = "type_id") %>%
  left_join(parties_eu, by = "id") %>%
  select(country_id, party_id, party_name_english, seats, total_seats) %>%
  mutate(seat_share = round(100 * seats / total_seats, 1))

