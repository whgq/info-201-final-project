library(dplyr)
library(purrr)
library(stringr)

locales <- c("metro", "region", "city")
timeframes <- c("04-08", "08-12", "12-16", "16-20", "20-24")

read_imm_reg_timeframe <- function(region, daterange) {
  path <- str_c(
    "./data_cleaned/google_trends/query_immigration_",
    region,
    "_",
    daterange,
    "-election.csv"
  )

  read.csv(path, skip = 2) %>%
    mutate(daterange = daterange) %>%
    (\(df) df %>% rename(query_incidence = names(df)[2]))()
}

# Get all combinations of region selectors and time frames
# Then clean up NA values
expand.grid(region = locales, daterange = timeframes) %>%
  pmap_dfr(read_imm_reg_timeframe) %>%
  write.csv("./data_cleaned/google_trends/summarized.csv")
