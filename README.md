# Text wrangling in R

## Setup

Clone the repository and navigate to the project directory:

```bash
git clone
cd text_wrangling_in_r
```

Double-click on the text_wrangling_in_r.Rproj file to open the project in RStudio.

### `renv` setup

This project uses the `renv` package to manage dependencies.
To set up the project environment, follow these steps:

1. Install the `renv` package if you haven't already: `r install.packages("renv")`
2. If you haven't opened the folder as a project in RStudio, ensure that your working directory is set to the project directory.
3. Run the following command to install the required packages: `r renv::restore("renv.lock")`

### Required packages

The below code chunk lists the required packages and comments indicate the minimal requried version.
Note that these packages will automatically installed in a local envrionment if you follow the `renv` setup instructions above. 

```
stringi # ≥ 1.7.12
stringr # ≥ 1.5.0
utf8 # ≥ 1.2.4
dplyr # ≥ 1.1.4
purrr # ≥ 1.0.2
readr # ≥ 2.1.5
tidyr # ≥ 1.3.1
xml2 # ≥ 1.3.6
dataverse # ≥ 0.3.13
readxl # ≥ 1.4.3
rmarkdown # ≥ 2.21
xml2 # ≥ 1.3.6
officer # ≥ 0.6.5
pdftools # ≥ 3.4.0
```