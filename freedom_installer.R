
# Mise en place
rm(list =ls())
setwd('C:/Users/03149822/Desktop/geo_political_index')

# libraries
library(readxl)
library(zoo)

url <- 'https://freedomhouse.org/sites/default/files/2024-02/Country_and_Territory_Ratings_and_Statuses_FIW_1973-2024.xlsx'

# download
download.file(url, paste('C:/Users/03149822/Desktop/geo_political_index/', 'freedom_indicator.xlsx', sep = ''), mode = 'wb')

# read
freedom <- read_excel('C:/Users/03149822/Desktop/geo_political_index/freedom_indicator.xlsx', sheet = 'Country Ratings, Statuses ')

# multiple header rows: https://readxl.tidyverse.org/articles/multiple-header-rows.html


# perhaps another good source for mass download: 

# democracy index: https://v-dem.net/data/the-v-dem-dataset/

# military expenditure:  https://www.sipri.org/databases/milex

# arms trade:  https://www.sipri.org/databases/armstransfers

# water stress index: https://www.wri.org/aqueduct/data

# energy consumption: https://ember-energy.org/data/yearly-electricity-data/

# energy: https://www.energyinst.org/__data/assets/excel_doc/0020/1540550/EI-Stats-Review-All-Data.xlsx

# blackrock risk dashboard: https://www.blackrock.com/corporate/insights/blackrock-investment-institute/interactive-charts/geopolitical-risk-dashboard#risk-summary

# european commission: https://drmkc.jrc.ec.europa.eu/inform-index/INFORM-Risk/Country-Risk-Profile

# political stability WB: https://databank.worldbank.org/source/worldwide-governance-indicators/Series/PV.EST

# corruption perception in EU: https://files.transparencycdn.org/images/GCB-EU-2021-National-results.xlsx

# formal alliances: https://correlatesofwar.org/data-sets/

# cyber incidents: https://eurepoc.eu/database/

# diplomatic representation: https://korbel.du.edu/pardee/research/project/diplomatic-representation-dataset

# voting alignment in UNGA: https://digitallibrary.un.org/record/4060887?ln=en

# global conflicts: https://acleddata.com/conflict-index/#downloads

# supply chain integration: https://portwatch.imf.org/

# european fragmentation (eurobarometer): https://data.europa.eu/data/datasets/s3215_102_2_std102_eng?locale=en

