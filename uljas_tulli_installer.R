
# examples here: https://tilastot.tulli.fi/uljas-tilastotietokanta/uljas-api
# manual: https://tilastot.tulli.fi/documents/179508185/203434370/Instructions%20for%20API%20manual/355ef7db-0e73-4393-a36d-89eff4fe643f/Instructions%20for%20API%20manual.pdf?version=1.0&t=1482326986000

# Mise en place
(list =ls())rm
setwd('C:/Users/03149822/Desktop/geo_political_index')

# libraries
library(httr)
library(jsonlite)

url <- 'https://uljas.tulli.fi/uljas/graph/api.aspx'


# define query parameters
params <- list(
  lang = 'fi',
  atype = 'data',
  konv = 'json',
  ifile = '/DATABASE/01 ULKOMAANKAUPPATILASTOT/02 SITC/ULJAS_SITC',
  `Tavaraluokitus SITC1` = "1",
  Maa = 'US',
  Aika = '=FIRST*;12',
  Suunta = '2',
  Indikaattorit = 'V1'
)

response <- GET(url, query = params)

# check the response status
if (status_code(response) == 200) {
  # parse the JSON content
  data <- content(response, as = 'text', encoding = 'UTF-8')
  parsed_data <- fromJSON(data, flatten = T)
  # print the data
  print(parsed_data)
} else {
  # print error message
  print(paste('Request failed with status code:', status_code(response)))
}
