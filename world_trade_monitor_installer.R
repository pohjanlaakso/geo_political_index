
# 'https://www.cpb.nl/sites/default/files/omnidownload/CPB-World-Trade-Monitor-November-2024.xlsx'
base_url <- 'https://www.cpb.nl/sites/default/files/omnidownload/CPB-World-Trade-Monitor'

# new prior month data on every month's 25th day. 

date <- Sys.Date() # 2025-01-27
month_number <- format(date, '%m') # 01
year <- format(date, '%Y') # 2025

month_names <- c('January', 'February', 'March', 'April', 'May', 'June',
                 'July', 'August', 'September', 'October', 'November', 'December')

month_name <- month_names[as.numeric(month_number)] # January

month_name_function <- function(i) {
  return(month_names[as.numeric(i)])
}


target_month_index <- (as.numeric(month_number) - 1) %% 12 # 0

# # handle December -> January case
if (target_month_index == 0) {
  target_month_index <- 12
  year <- as.numeric(year) - 1
}

target_month_name <- month_names[as.numeric(target_month_index)] # December

# tryCatch() until data is found

for(i in target_month_index:1) {
  tryCatch(
    {
      url <- paste(base_url, month_name_function(i), year, sep = '-'); print(url)
      download.file(url, paste('C:/Users/03149822/Desktop/geo_political_index/', 'trade_monitor.xlsx', sep = ''), mode = 'wb')
      trade_monitor <- read_excel('C:/Users/03149822/Desktop/geo_political_index/trade_monitor.xlsx')
    }, error = function(e) {
      cat(paste('Error downloading from', url, ':', e$message, '\n'))
    }
  )
}

