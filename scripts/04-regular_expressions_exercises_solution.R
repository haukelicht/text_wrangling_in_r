library(readr)
library(dplyr)
library(tidyr)

fp <- file.path("data", "datasets", "parlspeech2_gbr_sample.tsv")
df <- read_tsv(fp)

## Exercises (part 1) ----

# 1. What is the share of speeches that starts with the words "The" or "My"?
df |> 
  mutate(starts_with_the_or_my = grepl("^(The|My)", text)) |>
  with(table(starts_with_the_or_my)) |> 
  prop.table()

# 2. "hon." who?
#  1. Extract all occurrences of the pattern "hon." followed by a white space and a title-case word
occurrences <- df$text |> 
  str_extract_all("hon\\. [A-Z][a-z]+") |> 
  unlist()
#  2. Count the number of times the words after "hon." occur
sort(table(occurrences), decreasing = TRUE)


## Exercises (part 2) ----

# let's first define the parts of the pattern and then combine them

# (i) title-case word pattern: one uppercase letters followed by one or more lowercase letters, potentially followed by a hyphen and another title-case word
word_pattern <- "[A-Z][a-z]+(-[A-Z][a-z]+)?"
# (ii) constituency name pattern: "for" followed by one to four words, possible separated by commas or "and"
constituency_name_pattern <- sprintf(" for %s(( |, | and )%s){0,3}", word_pattern, word_pattern)
# (ii) MP name pattern: white space followed by opening and closing parentheses with one or more of any characters in between  except closing parentheses
mp_name_pattern <- "( \\([^\\)]+\\))?" # note: the name might or might not be specified

# combine
first_pattern <- paste0(constituency_name_pattern, mp_name_pattern)
subsequent_patterns <- paste0("((,| and)", first_pattern, ")*")
pat <- paste0("Members?( of Parliament)?", first_pattern, subsequent_patterns)

# extract all occurences
occurrences <- df |>
  pull(text) |> 
  str_extract_all(pat) |> 
  unlist()

# create a tibble with the extracted mentions
mentions <- tibble(mention = occurrences)

# reshape the data
mentions <- mentions |> 
  # remove the "Member..." prefix
  mutate(mention = str_remove(mention, "^Members?( of Parliament)? for ")) |> 
  # separate multi-MP constituency mentions, each into a separate row (won't affect "Member ..." instances)
  separate_rows(mention, sep = "(,| and) for") |>
  # separate the constituency and, if exists, the MP name information
  separate(mention, into = c("constituency", "mp"), sep = " \\(", fill = "right") |> 
  # clean up the MP name information
  mutate(mp = str_remove(mp, "\\)$"))

# show top-20 constituencies
mentions |> 
  count(constituency) |>
  arrange(desc(n)) |> 
  head(20)

# show bottom-20 constituencies
mentions |> 
  count(constituency) |>
  arrange(desc(n)) |> 
  tail(20)
# note: shows some parsing issue 
#  e.g. "Wakefield, David Hinchliffe" => part behind comma is the MP's name

# show top-20 MPs
mentions |> 
  count(mp) |>
  arrange(desc(n)) |> 
  head(20)
# note: many of the last names are likely not unique

# show bottom-20 MPs
mentions |> 
  count(mp) |>
  arrange(desc(n)) |> 
  tail(20)
