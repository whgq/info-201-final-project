library(dplyr)
library(purrr)
library(stringr)
library(readr)

split_df_head_tail <- function(df, n) {
  head <- df %>% head(n)
  tail <- df %>% tail(n = (df %>% nrow) - n)

  list(chunk = head, acc = tail)
}

# N rows per output split file
read_csv_gz <- function(path, chunk_size) {
  df <- path %>% read_csv(lazy = TRUE)

  # Find number of chunks, for each chunk, call split_df_head_tail
  # continually make df smaller, taking chunks of it of equal size
  # each time
  (1:((df %>% nrow) %/% chunk_size)) %>%
    accumulate(.f = \(df, i) {
      res <- df %>%
        split_df_head_tail(n = chunk_size)

      res[["chunk"]] %>% write.csv(str_c(path, "_", i, ".csv.gz"))

      res[["acc"]]
    }, .init = df)
}

read_csv_gz(
  "data/apprehensions_origins/Family Units apprehended along the SWB FY2000 Redacted_raw.xlsx.csv.gz",
  5)
