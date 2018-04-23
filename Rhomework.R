library(tidyverse)
library(gridExtra)
#download.file("https://ndownloader.figshare.com/files/2292169",
#              "data/portal_data_joined.csv")
surveys <- read.csv("surveys(1).csv")

surveys_complete <- surveys %>%
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex),
         species_id != "")

weightplot <- ggplot(surveys_complete, aes(x=species_id, y = weight)) +
  geom_jitter(alpha = .1,color = "blue") + geom_boxplot(alpha =.5) +
  xlab("Species ID")+ylab("Weight (kg)") +  ggtitle("Individual Weight by Species")

lengthplot <- ggplot(surveys_complete, aes(x=species_id, y = hindfoot_length)) +
  geom_jitter(alpha = .1,color = "red") + geom_boxplot(alpha =.5) +
  xlab("Species ID")+ylab("Hindfoot Length (cm)")+  ggtitle("Individual Hindfoot Length by Species")


grid.arrange(weightplot,lengthplot)

ggplot(surveys_complete, aes(x=weight, y = hindfoot_length)) +
  geom_point(alpha = .05,color = "blue") + xlab("Weight (kg)")+
  ylab("Hindfoot Length (cm)")+ggtitle("Weight vs. Hindfoot Length of Individuals")


weightlength.lm <- lm(weight ~ hindfoot_length, data=surveys_complete)
#summary(weightlength.lm)
#r-squared 0.4673
#p 2.2e-16

mean_wl <- surveys_complete %>% group_by(species_id) %>%
  summarize(mean_length = mean(hindfoot_length),
            mean_weight = mean(weight))

ggplot(mean_wl, aes(x=mean_weight, y=mean_length, color=species_id))+
  geom_point()+xlab("Mean Weight (kg)")+ylab("Mean Hindfoot Length (cm)")+
  ggtitle("Average Weight vs. Hindfoot Length by Species")

mean.lm <- lm(mean_weight ~ mean_length, data=mean_wl)
#summary(mean.lm)
#R-squared 0.5784
#p 9.728e-06