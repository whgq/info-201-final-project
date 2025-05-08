library(dplyr)
library(stringr)
library(readr)
library(purrr)

# N rows per output split file
# Blocks of 100,000 rows by default
read_csv_gz <- function(path, chunk_size = 100000) {
  df <- path %>% read_csv

  df %>%
    mutate(chunk = (row_number() - 1) %/% chunk_size) %>%
    group_by(chunk) %>%
    group_split(.keep = FALSE) %>%
    imap(\(chunk, i) {
      fname <- str_c(path, "_", i, ".csv.gz")
      chunk %>% write_csv(fname)

      fname
    })
}

read_csv_gz("./data/apprehensions_origins/Family Units apprehended along the SWB FY2000 Redacted_raw.xlsx.csv.gz") %>% print
