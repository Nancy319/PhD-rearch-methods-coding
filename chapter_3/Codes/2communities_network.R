library(readr)
library(dplyr)

covid_coocs_release_20 <- read.csv("covid_coocs_release_20.csv")
covid_coocs_legi_20 <- read.csv("covid_coocs_legiDoc_20.csv")
covid_coocs_cord_20 <- read_csv("cord_cooccurrence_20.csv")

covid_coocs_release_20$type <- "release"
covid_coocs_legi_20$type <- "legiDoc"
covid_coocs_cord_20$type <- "research"

covid_coocs_cord_20 <-covid_coocs_cord_20 %>%
  rename(X=X1)

##release
covid_coocs_release_20_edge<- covid_coocs_release_20 %>%
  select(source=from,target=to)
allNodes_release.1 <- unique(covid_coocs_release_20[,c(2,5)])
colnames(allNodes_release.1) <- c("Id","type")
allNodess_release.2 <- unique(covid_coocs_release_20[,c(3,5)])
colnames(allNodess_release.2) <- c("Id","type")
allNodes_release <- unique(rbind(allNodes_release.1,allNodess_release.2))
write_csv(covid_coocs_release_20_edge,"netRelease.csv")
write_csv(allNodes_release,"netRelease_nodes.csv")

##legiDoc
covid_coocs_legiDoc_20_edge<- covid_coocs_legi_20 %>%
  select(source=from,target=to)
allNodes_legiDoc.1 <- unique(covid_coocs_legi_20[,c(2,5)])
colnames(allNodes_legiDoc.1) <- c("Id","type")
allNodess_legiDoc.2 <- unique(covid_coocs_legi_20[,c(3,5)])
colnames(allNodess_legiDoc.2) <- c("Id","type")
allNodes_legiDoc <- unique(rbind(allNodes_legiDoc.1,allNodess_legiDoc.2))
write_csv(covid_coocs_legiDoc_20_edge,"netLegiDoc.csv")
write_csv(allNodes_legiDoc,"netLegiDoc_nodes.csv")

##cord
covid_coocs_cord_20_edge<- covid_coocs_cord_20 %>%
  select(source=from,target=to)
allNodes_cord.1 <- unique(covid_coocs_cord_20[,c(2,5)])
colnames(allNodes_cord.1) <- c("Id","type")
allNodess_cord.2 <- unique(covid_coocs_cord_20[,c(3,5)])
colnames(allNodess_cord.2) <- c("Id","type")
allNodes_cord <- unique(rbind(allNodes_cord.1,allNodess_cord.2))
write_csv(covid_coocs_cord_20_edge,"netcord.csv")
write_csv(allNodes_cord,"netcord_nodes.csv")

##combined
combined_coocs_2communities <- rbind(covid_coocs_release_20,covid_coocs_legi_20,covid_coocs_cord_20)
combined_coocs_2communities.agg <- aggregate(type~from+to,combined_coocs_2communities,paste,collapse="&")
colnames(combined_coocs_2communities.agg) <- c("source","target","class")

allNodes_2communities <- unique(rbind(allNodes_release,allNodes_legiDoc,allNodes_cord))
allNodes_2communities.agg <- aggregate(type~Id,allNodes_2communities,paste,collapse="&")
write_csv(combined_coocs_2communities.agg,"net_2communities.csv")
write_csv(allNodes_2communities.agg,"net_nodes_2communities.csv")
