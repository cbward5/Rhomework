library(tidyverse)
download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")
surveys <- read_csv("data/portal_data_joined.csv")

surveys_complete <- surveys %>%
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex),
         species_id != "")

ggplot(surveys_complete, aes(x=species_id, y = weight)) +
  geom_jitter(alpha = .1,color = "blue") + geom_boxplot(alpha =.5)

ggplot(surveys_complete, aes(x=species_id, y = hindfoot_length)) +
  geom_jitter(alpha = .1,color = "red") + geom_boxplot(alpha =.5)
