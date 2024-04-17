library(readr)
library(dplyr)
library(dataverse)
library()

Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")
Sys.setenv("DATAVERSE_ID" = "ParlSpeech") # set to ParlSpeech dataverse

# download
df <- get_dataframe_by_doi("doi:10.7910/DVN/L4OAKN/W2SVMF", .f = read_rds)

# max speech number digits?
df$speechnumber |> as.character() |> nchar() |> max()
# most frequent parties?
parties <- df$party |> table() |> sort(decreasing = TRUE) |> head(5) |> names()

# sample:
set.seed(1234)
sampled <- df |> 
  filter(party %in% parties) |>
  group_by(date, party) |>   
  # sample at most 3 speeches
  sample_n(size = min(2, n())) |> 
  transmute(
    # create unique speech ID
    speech_id = sprintf("%s_%04d", date, speechnumber),
    text
  )

fp <- file.path("data", "datasets", "parlspeech2_gbr_sample.tsv")
write_tsv(sampled, fp)
