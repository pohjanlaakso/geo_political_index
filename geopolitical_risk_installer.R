
# Mise en place
rm(list =ls())
setwd('C:/Users/03149822/Desktop/geo_political_index')

# libraries
library(readxl)
library(zoo)

url <- 'https://www.matteoiacoviello.com/gpr_files/data_gpr_export.xls'

# download
download.file(url, paste('C:/Users/03149822/Desktop/geo_political_index/', 'georisk_monthly.xls', sep = ''), mode = 'wb')

# read
georisk <- read_excel('C:/Users/03149822/Desktop/geo_political_index/georisk_monthly.xls')
sapply(georisk, class)

# plot
plot.ts(georisk$GPRH)

georisk_70s <- tail(georisk, -840)

# 1991 = fall of USSR; 2001 = WTC-attack; 2020 = pandemic; 81-82 = ?
plot.ts(georisk_70s$GPRH, xaxt = 'n', ylab = '', lty = 3)
axis(1, at = seq(1, 56*12, by = 12), labels = 1970:2025)
lines(rollmean(georisk_70s$GPRH, k = 12), col = 'red') 