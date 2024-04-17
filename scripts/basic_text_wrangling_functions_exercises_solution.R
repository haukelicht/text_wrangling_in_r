# +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~ #  
#
#' @title  Solutions for exercises in slide set "Basic text wrangling functions"
#' @author Hauke Licht
#' @date   2024-04-17
#
# +~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~ #

# setup ----

library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# Exercise 1 ----


## Exercise 1, first part ----

# 1. read the sample of the ParlSpeech2 *UK Hose of Commons* corpus I have created
fp <- file.path("data", "datasets", "parlspeech2_gbr_sample.tsv")
df <- read_tsv(fp)

# 2. group the data by *party* and *date* using `dplyr::group_by`
# 3. use `dplyr::summarize` and `paste` to aggregate ("combine") speeches by party and date
# 4. use `dplyr::mutate` and `sprintf` to create a new column with a unique identifier for each party--date text unit

party_date_speeches <- df |> 
  group_by(date, party) |> 
  summarize(text = paste(text, collapse = " ")) |>
  mutate(text_id = sprintf("%s_%s", date, party))

## Exercise 1, second part ----

# 1. Take the data frame of party--date level speech texts created previously
# 2. Use `dplyr::mutate` and `nchar` to create a new column with the number of characters in each text
# 3. Use `dplyr::mutate` and `grepl` to create an indicator "mentions_brexit" that is `True` if a party--date text unit contains the term "Brexit" and `False` otherwise

party_date_speeches <- party_date_speeches |> 
  mutate(
    n_chars = nchar(text),
    mentions_brexit = grepl("Brexit", text)
  )

# 4. Summarize the proportion of party--date text units that contain the term "Brexit" by party and year
# 5. Analyze:
#     1. In what year was the term "Brexit" most prevalent?
#     2. Does the answer to 5.1 depend on the party?

party_date_speeches |> 
  mutate(year = as.integer(substr(text_id, 1, 4))) |> 
  filter(year > 2010) |>
  group_by(year, party) |> 
  summarize(
    prop_mentions_brexit = mean(mentions_brexit)
  ) |> 
  ungroup() |> 
  pivot_wider(names_from = "party", values_from = "prop_mentions_brexit") |> 
  round(3)

## Exercise 1. third part ----

# 1. Take the data frame of party--date level speech texts with the "mentions_brexit" created previously
# 2. locate the character positions where the term "Brexit" occurs

res <- party_date_speeches |> 
  filter(mentions_brexit) |> 
  mutate(
    brexit_pos = str_locate_all(text, "Brexit")
  ) |> 
  select(text, brexit_pos) 

# note: the format is a little wild
#  a) the `brexit_pos` column is a list column
class(res$brexit_pos)
#  b) each list value is a matrix with two columns: start and end positions of the term "Brexit"
res$brexit_pos[1:2]


# 3.1. for each occurrence, extract the term "Brexit" ± 20 characters left and right of it
library(purrr)
offset <- 20
brexit_mentions <- res |> 
  mutate(
    brexit_pos = map(brexit_pos, as.data.frame)
  ) |> 
  unnest(brexit_pos) |>
  rowwise() |> 
  mutate(
    start = start-offset,
    end = end+offset,
    mention = substr(text, start, end)
  )

# 3.2. what are the 20 terms that most frequently co-occur in the ±20 character window with the term "Brexit"?
brexit_mentions$mention |> 
  trimws() |> 
  str_split(" ") |> 
  unlist() |> 
  table() |> 
  sort(decreasing = TRUE) |>
  names() |> 
  setdiff(c("Brexit", "Brexit,", "Brexit.")) |> 
  head(20)

