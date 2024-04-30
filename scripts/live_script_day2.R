

x <- c("apple", "banana", "cherry")
idx <- grep("a", x)
x[idx]
# alternatively:
grep(pattern = "a", x, value = TRUE)


grepl(pattern = "a", x)
idx <- grepl("a", x)
x[idx]



x <- "Hello, World!"
sub(pattern = "World", replacement = "Universe", x)
x <- "Hello, World World!"
sub(pattern = "World", replacement = "Universe", x) # <== only first occurrence
gsub(pattern = "World", replacement = "Universe", x)  # <== all occurrences

x <- c("a b c", "d e f g", "h", NA)
strsplit(x, split = " ")

x <- c("a_b_c", "d_e_f_g", "h", NA)
strsplit(x, split = "")

# count unioque characters occurrences:
chars <- strsplit(x, split = "")
sort(table(unlist(chars)), decreasing = TRUE)


library(readr)
fp <- file.path("data", "datasets", "parlspeech2_gbr_sample.tsv")
df <- read_tsv(fp)
chars <- strsplit(df$text, split = "")
sort(table(unlist(chars)), decreasing = TRUE)


