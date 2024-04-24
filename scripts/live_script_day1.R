# show the absolute path of your home directory
path.expand("~/Desktop")

list.files("~/Desktop")
list.files("/Users/hlicht/Desktop")

getwd()
list.files(getwd()) # <== look at files in current working directory
list.files(".") # <== look at current loation in file system

list.files("data")

list.files("/Users/hlicht/Dropbox/teaching/text_wrangling_in_r/data")
list.files("~/Dropbox/teaching/text_wrangling_in_r/data")

read.csv("data/tabular/test.csv")

# create a path under the current system
fp <- file.path("folder", "subfolder", "file.txt")
fp

# logic for writing a files without overwriting it
fp <- file.path("data", "tabular", "mtcars.csv")
if (!file.exists(fp)) {
  readr::write_csv(mtcars, fp)
  message(Sys.time(), ": written file")
}

# logic for writing a files without overwriting it
fp <- file.path("data", "abc")
dir.exists(fp)
dir.create(fp, showWarnings = FALSE)
unlink(fp, recursive = TRUE)



library(readr)
# read CSV file
fp <- file.path("data", "tabular", "test.csv")
df <- read_csv(fp)
df

# read TSV file
fp <- file.path("data", "tabular", "test.tsv")
df <- read_tsv(fp)
df

library(readxl)
# read Excel file
fp <- file.path("data", "tabular", "test.xlsx")
df <- read_excel(fp)
df

average <- mean(1:4)

# read multiple files? see also package "readtext"


url <- "https://dataverse.harvard.edu/api/access/datafile/7522197"
read_tsv(url)

file_url <- "https://dataverse.harvard.edu/api/access/datafile/5374866"
# we use `read_tsv` because the file we want to download is a .tab file, i.e. "tab-separated"
df <- read_tsv(file_url)  

View(df)



library(dataverse)
Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")
Sys.setenv("DATAVERSE_ID" = "pan") # set to Political Analysis dataverse ID !

persistent_id <- "doi:10.7910/DVN/MXKRDE/EJTMLZ"

df <- get_dataframe_by_doi(
  filedoi = persistent_id,
  version = "1.2"
)

df

"a"
a

a <- 1

a

read_csv("https://raw.githubusercontent.com/vanatteveldt/ecosent/master/data/raw/gold_sentences.csv")



character_value <- "Hello world!"
character_value <- 'Hello world!'

character_value <- "Hello world, what's up?"
character_value <- 'Hello world, what\'s up?'
character_value <- "Hello world, what\"s up?"
character_value <- 'Hello world, what"s up?'


x <- c("a", "b", "c")
y <- c("1", "2", "3")
paste(x, sep = ":")
paste(x, collapse = ":")
paste(x, y, sep = ":")
paste(x, y, sep = ":", collapse = "<SEP>")

sprintf(fmt = "Hello, %s! My name is %s", "Death Star", "Naomi")

df <- data.frame(
  document_number = c(1, 1, 2, 2),
  paragraph_number = c(1, 2, 1, 2),
  text = letters[1:4]
)

df$text_uid <- sprintf("d%02d_p%02d", df$document_number, df$paragraph_number)
# is unqiue
length(unique(df$text_uid)) == nrow(df)

df <- data.frame(
  id =  c(
    sprintf("%03d", 3),
    sprintf("%03d", 20),
    sprintf("%03d", 100)
  )
)
df
library(dplyr)
df |> arrange(id)



sprintf("%03.0f", 1)
sprintf("%03.3f", 1)
sprintf("%+.03f", 1.2343456346)
sprintf("%0.012f", -1.2343456346)
