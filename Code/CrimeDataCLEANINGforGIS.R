install.packages("dplyr")
install.packages("tidyr")
library(dplyr)
library(tidyr)
crimestats<-read.csv("INSERT FILE PATH HERE")

View(crimestats)

codelist<- list(unique(crimestats$nibrs_code))
print(codelist)



crimeWide<-crimestats %>%
  group_by(location_zip) %>%
  mutate(row = row_number()) %>%
  pivot_wider(names_from = nibrs_code,
              values_from = total,
              names_prefix = "c_",
              values_fill = 0) %>%
  summarise(across(c_23H:c_11C, sum, na.rm=F))

View(crimeWide)



codeKeyTEMP <- crimestats %>%
  transmute(nibrs_code = nibrs_code, total_occurances = total) %>%
  group_by(nibrs_code) %>%
  summarise_all(sum)

View(codeKeyTEMP)

codeKey <- crimestats %>%
  transmute(nibrs_code = nibrs_code, description = nibrs_description) %>%
  distinct(nibrs_code, description) %>%
  left_join(codeKeyTEMP)
  

View(codeKey)



#checking for accuracy

sum(crimeWide$c_23H)
codeKey


# Summary graphic for internal use with key

library(ggplot2)
?ggplot
#ggplot(codeKey, aes(description, total_occurances)) + geom_col() +
#  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

library(dplyr)
ViolentList <- c("11A", "13A", "120","09A","11C")
codeKey$Violent<-"no"

for (i in ViolentList){
codeKey$Violent[codeKey$nibrs_code == i] <-"yes" }

View(codeKey)

ggplot(codeKey, aes(description, total_occurances, fill=(Violent))) + geom_col() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_manual(values=c("grey","red")) + xlab("Crime Type") + ylab("Occurances") +
  labs(fill = "Violent \nCrime") + ggtitle("Crime Occurances in Ohio \nfor 2024 SHMP Summary")


write.csv(crimeWide,"INSERT FILE PATH HERE")
write.csv(codeKey,"INSERT FILE PATH HERE")
