library(dplyr)


invasive_List_raw<-read.csv("/Users/coyoteobjective/Desktop/ToDo_OhioEMA/2.13/Research/EddMap.csv")
View(invasive_List_raw)


unique(invasive_List_raw$ComName)

Invasive_Grouped<-invasive_List_raw %>% group_by(ComName) %>% count

head(invasive_List_raw)




GarlicMustard<- invasive_List_raw %>% filter(ComName == "garlic mustard") %>%
  group_by(Location) %>% count

colnames(GarlicMustard)[2]="Garlic Mustard"

GarlicMustard$Location<-gsub("^(.*?),.*","\\1", GarlicMustard$Location)
GarlicMustard$Location<-sub('.','', GarlicMustard$Location)




BushHoneysuckle<- invasive_List_raw %>% filter(ComName == "bush honeysuckles (exotic)") %>%
  group_by(Location) %>% count

colnames(BushHoneysuckle)[2]="Bush Honeysuckle"

BushHoneysuckle$Location<-gsub("^(.*?),.*","\\1", BushHoneysuckle$Location)
BushHoneysuckle$Location<-sub('.','', BushHoneysuckle$Location)




JapaneseHoneysuckle<- invasive_List_raw %>% filter(ComName == "Japanese honeysuckle") %>%
  group_by(Location) %>% count

colnames(JapaneseHoneysuckle)[2]="Japanese Honeysuckle"

JapaneseHoneysuckle$Location<-gsub("^(.*?),.*","\\1", JapaneseHoneysuckle$Location)
JapaneseHoneysuckle$Location<-sub('.','', JapaneseHoneysuckle$Location)




AutumnOlive<- invasive_List_raw %>% filter(ComName == "autumn olive") %>%
  group_by(Location) %>% count

colnames(AutumnOlive)[2]="Autumn Olive"

AutumnOlive$Location<-gsub("^(.*?),.*","\\1", AutumnOlive$Location)
AutumnOlive$Location<-sub('.','', AutumnOlive$Location)




Buckthorn<- invasive_List_raw %>% filter(ComName == "buckhorn plantain") %>%
  group_by(Location) %>% count

colnames(Buckthorn)[2]="Buckthorn"

Buckthorn$Location<-gsub("^(.*?),.*","\\1", Buckthorn$Location)
Buckthorn$Location<-sub('.','', Buckthorn$Location)




CommonReed<- invasive_List_raw %>% filter(ComName == "European common reed, Phragmites") %>%
  group_by(Location) %>% count

colnames(CommonReed)[2]="Common Reed"

CommonReed$Location<-gsub("^(.*?),.*","\\1", CommonReed$Location)
CommonReed$Location<-sub('.','', CommonReed$Location)




JapaneseKnotweed<- invasive_List_raw %>% filter(ComName == "Japanese knotweed") %>%
  group_by(Location) %>% count

colnames(JapaneseKnotweed)[2]="Japanese Knotweed"

JapaneseKnotweed$Location<-gsub("^(.*?),.*","\\1", JapaneseKnotweed$Location)
JapaneseKnotweed$Location<-sub('.','', JapaneseKnotweed$Location)




MultifloraRose<- invasive_List_raw %>% filter(ComName == "multiflora rose") %>%
  group_by(Location) %>% count

colnames(MultifloraRose)[2]="Multiflora Rose"

MultifloraRose$Location<-gsub("^(.*?),.*","\\1", MultifloraRose$Location)
MultifloraRose$Location<-sub('.','', MultifloraRose$Location)




PurpleLoosestrife<- invasive_List_raw %>% filter(ComName == "purple loosestrife") %>%
  group_by(Location) %>% count

colnames(PurpleLoosestrife)[2]="Purple Loosestrife"

PurpleLoosestrife$Location<-gsub("^(.*?),.*","\\1", PurpleLoosestrife$Location)
PurpleLoosestrife$Location<-sub('.','', PurpleLoosestrife$Location)




ReedCanaryGrass<- invasive_List_raw %>% filter(ComName == "reed canarygrass") %>%
  group_by(Location) %>% count

colnames(ReedCanaryGrass)[2]="Reed Canarygrass"

ReedCanaryGrass$Location<-gsub("^(.*?),.*","\\1", ReedCanaryGrass$Location)
ReedCanaryGrass$Location<-sub('.','', ReedCanaryGrass$Location)



DataFrame_Lists<-list(GarlicMustard,
                      BushHoneysuckle,
                      JapaneseHoneysuckle,
                      AutumnOlive,
                      Buckthorn,
                      CommonReed,
                      JapaneseKnotweed,
                      MultifloraRose,
                      PurpleLoosestrife,
                      ReedCanaryGrass)

County_TOP10<-Reduce(function(x,y) merge(x,y, all=TRUE), DataFrame_Lists)

County_TOP10$Total_Present = rowSums(!is.na(County_TOP10[-1]))

write.csv(County_TOP10,"/Users/coyoteobjective/Desktop/ToDo_OhioEMA/2.13/CountyTopTen.csv")
