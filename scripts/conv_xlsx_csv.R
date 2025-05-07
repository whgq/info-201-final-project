library(dplyr)
library(stringr)

conv_xs <- function(fname) {
  fname.1 <- str_c(fname, ".csv.gz")

  readxl::read_xlsx(fname) %>%
    write.csv(file = fname.1)

  return(fname.1)
}

conv_many_xs <- function(path) {
  fs <- list.files(path)
  outfs <- c()

  for (f in fs) {
    if (!str_ends(f, ".xlsx")) {
      next
    }

    f.1 <- conv_xs(str_c(path, f))
    outfs <- outfs %>% c(f.1)
  }

  return(outfs)
}

conv_many_xs("./data/removals/") %>% print
conv_many_xs("./data/apprehensions_origins/") %>% print
