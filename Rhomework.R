library(tidyverse)
download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")
surveys <- read_csv("data/portal_data_joined.csv")
head(surveys)
#seeing if this works
