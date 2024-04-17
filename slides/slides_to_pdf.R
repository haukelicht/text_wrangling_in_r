library(purrr)
library(renderthis)

html_files <- list.files("slides", pattern = "\\.html$", include.dirs = FALSE, full.names = TRUE)

invisible(map(html_files, renderthis::to_pdf))
