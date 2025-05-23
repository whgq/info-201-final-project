library(dplyr)
library(purrr)
library(stringr)

locales <- c("metro")
timeframes <- c("04-08", "08-12", "12-16", "16-20", "20-24", "16-17", "17-18", "18-19", "19-20", "20-21", "21-22", "22-23", "23-24")

read_imm_reg_timeframe <- function(region, daterange) {
  path <- str_c(
    "./data_cleaned/google_trends/query_immigration_",
    region,
    "_",
    daterange,
    "-election.csv"
  )

  df <- read.csv(path)

  df %>%
    mutate("daterange" = daterange) %>%
    (\(df) df %>% rename(query_incidence = names(df)[2]))() %>%
    select(DMA, daterange, query_incidence)
}

# Get all combinations of region selectors and time frames
# Then clean up NA values
expand.grid(region = locales, daterange = timeframes) %>%
  pmap_dfr(read_imm_reg_timeframe) %>%
  write.csv("./data_cleaned/google_trends/summarized.csv")
