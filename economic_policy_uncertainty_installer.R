
# Mise en place
rm(list =ls())
setwd('C:/Users/03149822/Desktop/geo_political_index')

# libraries
library(readxl)
library(zoo)

# World uncertainty index URLs
url_monthly <- 'https://worlduncertaintyindex.com/wp-content/uploads/2025/01/WUI_M_dataset_2024_12.xlsx'
url_quarterly <- 'https://worlduncertaintyindex.com/wp-content/uploads/2025/01/WUI_Data.xlsx'
url_spillover <- 'https://worlduncertaintyindex.com/wp-content/uploads/2025/01/WUSI_Data.xlsx'
url_pandemic <- 'https://worlduncertaintyindex.com/wp-content/uploads/2025/01/WPUI_Data.xlsx'

# download
download.file(url_monthly, paste('C:/Users/03149822/Desktop/geo_political_index/', 'wui_monthly.xlsx', sep = ''), mode = 'wb')

# read
wui_monthly <- read_excel('C:/Users/03149822/Desktop/geo_political_index/wui_monthly.xlsx', sheet = 'F1', range = cell_cols('A:B'))
sapply(wui_monthly, class)

# plot
plot.ts(wui_monthly$`WUI, GDP weighted average`, lty = 3, xaxt = 'n', ylab = '', 
        main = 'GDP weighted average of world trade uncertainty \n (N = 71)')
lines(rollmean(wui_monthly$`WUI, GDP weighted average`, k = 12, align = 'right'), col = 'red')
axis(1, at = seq(1, 18*12, by = 12), labels = 2008:2025)
