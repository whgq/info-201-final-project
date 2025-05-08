library(dplyr)
library(purrr)

split_df_head_tail <- function(df, n) {
  head <- df[1:n]
  tail <- df[n:(df %>% nrow)]

  c(head, tail)
}

# N rows per output split file
read_csv_gz <- function(path, chunk_size) {
  df <- read.delim(path)

  # Find number of chunks, for each chunk, call split_df_head_tail
  chunks <- (1:(df %>% nrow()) / chunk_size) |>
    accumulate(\(i, accum) {
      # accum[2] = current subset of df to split
      # accum[1] = all dfs created
      res <- accum[2] |>
        split_df_head_tail(n = chunk_size)

      c(accum[1] |> c(res[1]), res[2])
    })

  print(chumks[1] |> summarize)
}
