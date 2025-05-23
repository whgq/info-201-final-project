library(dplyr)
library(purrr)
library(stringr)
library(readr)
library(lubridate)

timestamp_file <- function(fname) {
  df <- read_csv(fname)

  if (!("DMA" %in% names(df))) {
    return(fname)
  }

  tfnames <- names(df)[2] %>%
      str_replace("Immigration: \\(", "") %>%
      str_replace("\\)", "") %>%
      str_split(" - ") %>%
      map(\(strdate) strdate %>%
                     parse_date(format = "%m/%d/%y") %>%
                     year %>% (\(d) d %% 100))

  new_name <- str_c("./data_cleaned/google_trends/query_immigration_metro_", tfnames[[1]][[1]], "-", tfnames[[1]][[2]], "-election.csv")
  df %>% write_csv(new_name)

  new_name
}

list.files("./data_cleaned/google_trends") %>%
    keep(\(fname) fname %>% str_detect("geoMap")) %>%
    map(\(fname) timestamp_file(str_c("./data_cleaned/google_trends/", fname)))

