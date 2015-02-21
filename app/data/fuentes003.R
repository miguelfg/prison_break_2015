################################################################################
## UN Office for Drugs and Crime
## http://www.unodc.org/unodc/en/data-and-analysis/statistics/data.html

# Read excel files
if(!file.exists("data")){dir.create("data")}
# fileUrl <- "http://www.unodc.org/documents/data-and-analysis/statistics/crime/CTS12_Persons_detained.xls"
# download.file(fileUrl, destfile="./varios/CTS12_Persons_detained.xls")
# dateDownloaded <- date()
library(xlsx)

# http://www.unodc.org/documents/data-and-analysis/statistics/crime/CTS12_Persons_detained.xls
# Download 2015-09-02
total_persons_held <-    read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=1, startRow=14, endRow=125, 
                                   header=TRUE)
head(total_persons_held)
summary(total_persons_held)

held_untried_pretrial <- read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=2, startRow=14, endRow=122, 
                                   header=TRUE)
head(held_untried_pretrial)
summary(held_untried_pretrial)

held_sentenced <-        read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=3, startRow=14, endRow=125, 
                                   header=TRUE)
head(held_sentenced)
summary(held_sentenced)

adults_held <-           read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=4, startRow=14, endRow=126, 
                                   header=TRUE)
head(adults_held)
summary(adults_held)

male_adults_held <-      read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=5, startRow=14, endRow=82, 
                                   header=TRUE)
head(male_adults_held)
summary(male_adults_held)

female_adults_held <-    read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=6, startRow=14, endRow=124, 
                                   header=TRUE)
head(female_adults_held)
summary(female_adults_held)

juveniles_held <-        read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=7, startRow=14, endRow=115, 
                                   header=TRUE)
head(juveniles_held)
summary(juveniles_held)

country_citizents <-     read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=8, startRow=14, endRow=88, 
                                   header=TRUE)
head(country_citizents)
summary(country_citizents)

foreign_citizents <-     read.xlsx("./varios/CTS12_Persons_detained.xls", 
                                   sheetIndex=9, startRow=14, endRow=122, 
                                   header=TRUE)
head(foreign_citizents)
summary(foreign_citizents)

# Delete empty columns
adults_held$NA. <- NULL
male_adults_held$NA. <- NULL
female_adults_held$NA. <- NULL
held_sentenced$NA. <- NULL
held_untried_pretrial$NA. <- NULL
juveniles_held$NA. <- NULL
total_persons_held$NA. <- NULL

levels(adults_held$Country.territory)           <- gsub(" \\*", "", levels(adults_held$Country.territory))
levels(country_citizents$Country.territory)     <- gsub(" \\*", "", levels(country_citizents$Country.territory))
levels(female_adults_held$Country.territory)    <- gsub(" \\*", "", levels(female_adults_held$Country.territory))
levels(foreign_citizents$Country.territory)     <- gsub(" \\*", "", levels(foreign_citizents$Country.territory))
levels(held_sentenced$Country.territory)        <- gsub(" \\*", "", levels(held_sentenced$Country.territory))
levels(held_untried_pretrial$Country.territory) <- gsub(" \\*", "", levels(held_untried_pretrial$Country.territory))
levels(juveniles_held$Country.territory)        <- gsub(" \\*", "", levels(juveniles_held$Country.territory))
levels(male_adults_held$Country.territory)      <- gsub(" \\*", "", levels(male_adults_held$Country.territory))
levels(total_persons_held$Country.territory)    <- gsub(" \\*", "", levels(total_persons_held$Country.territory))

# Sheets
sheets <- c("adults_held", "country_citizents", "female_adults", 
            "foreign_citizents", "held_sentenced", "held_untried", 
            "juveniles_held", "male_adults_held", "total_persons_held")

sheets_list <- as.list(sheets)

# Countries
countries <- levels(adults_held$Country.territory)

# world <- data.frame(country=as.factor(countries))

world_2010 <- data.frame(Country.territory=as.factor(levels(adults_held$Country.territory)), 
                         adults_held=adults_held$X2010)

world_2010 <- merge(world_2010, country_citizents[c("Country.territory", "X2010")], 
             by.x="Country.territory", by.y="Country.territory", all=TRUE)
names(world_2010)[names(world_2010)=="X2010"] <- "country_citizents"

world_2010 <- merge(world_2010, female_adults_held[c("Country.territory", "X2010")], 
             by.x="Country.territory", by.y="Country.territory", all=TRUE)
names(world_2010)[names(world_2010)=="X2010"] <- "female_adults_held"
head(world_2010)

world_2010 <- merge(world_2010, foreign_citizents[c("Country.territory", "X2010")], 
             by.x="Country.territory", by.y="Country.territory", all=TRUE)
names(world_2010)[names(world_2010)=="X2010"] <- "foreign_citizents"

world_2010 <- merge(world_2010, held_sentenced[c("Country.territory", "X2010")], 
             by.x="Country.territory", by.y="Country.territory", all=TRUE)
names(world_2010)[names(world_2010)=="X2010"] <- "held_sentenced"

world_2010 <- merge(world_2010, held_untried_pretrial[c("Country.territory", "X2010")], 
             by.x="Country.territory", by.y="Country.territory", all=TRUE)
names(world_2010)[names(world_2010)=="X2010"] <- "held_untried_pretrial"

world_2010 <- merge(world_2010, juveniles_held[c("Country.territory", "X2010")], 
             by.x="Country.territory", by.y="Country.territory", all=TRUE)
names(world_2010)[names(world_2010)=="X2010"] <- "juveniles_held"

world_2010 <- merge(world_2010, male_adults_held[c("Country.territory", "X2010")], 
             by.x="Country.territory", by.y="Country.territory", all=TRUE)
names(world_2010)[names(world_2010)=="X2010"] <- "male_adults_held"

world_2010 <- merge(world_2010, total_persons_held[c("Country.territory", "X2010")], 
             by.x="Country.territory", by.y="Country.territory", all=TRUE)
names(world_2010)[names(world_2010)=="X2010"] <- "total_persons_held"

# Look for countries with * in name (Changes in definitions and/or counting 
# rules are reported by the Member State to indicate a break in the time series.)

levels(world_2010$Country.territory)[!(levels(world_2010$Country.territory) %in% countries)]

levels(world_2010$Country.territory)

# save(world_2010, file="world_2010.RData")

