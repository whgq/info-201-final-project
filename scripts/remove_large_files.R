library(stringr)
library(purrr)

# Files that have .csv in their name twice are certainly clean files
# Don't delete those
delete_all_unclean_in <- function(path) {
  to_delete <- list.files(path) %>%
    discard(\(fname) str_count(fname, ".csv") == 2) %>%
    map(\(f) str_c(path, f)) %>%
    keep(file.exists)

  for (f in to_delete) {
    file.remove(f)
  }

  to_delete
}

delete_all_unclean_in("./data/removals/") %>% print
delete_all_unclean_in("./data/apprehensions_origins/") %>% print
