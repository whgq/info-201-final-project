library(dplyr)
library(stringr)
library(readr)
library(purrr)

# N rows per output split file
# Blocks of 100,000 rows by default
read_csv_gz <- function(path, chunk_size = 100000) {
  path %>%
    read_csv %>%
    mutate(chunk = (row_number() - 1) %/% chunk_size) %>%
    group_by(chunk) %>%
    group_split(.keep = FALSE) %>%
    imap(\(chunk, i) {
      fname <- str_c(path, "_", i, ".csv.gz")
      chunk %>% write_csv(fname)

      fname
    })
}

split_all_large_csvs <- function(path) {
  # Only consider csv files
  # Get all new file paths after chunking
  list.files(path) %>%
    keep(\(fname) str_ends(fname, ".csv.gz") || str_ends(fname, ".csv")) %>%
    map(\(fname) str_c(path, fname)) %>%
    map(read_csv_gz)
}

split_all_large_csvs("./data/apprehensions_origins/") %>% print
split_all_large_csvs("./data/removals/") %>% print
