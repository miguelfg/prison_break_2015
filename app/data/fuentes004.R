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

################################################################################

check.levels <- function (df, variable="Country.territory") {
      # deparse(substitute(df))
      # force(df)
      # variable="Country.territory"
      # print(levels(df[[variable]]))
      # print(df[[variable]])
      # df$Country.terrytory
      # print(paste0("df$", variable))
      # parse(paste0("df$", variable))
      # paste0(deparse(substitute(df)), "\\$", variable)
      # paste0(deparse(df), "$", variable)
      # deparse(df, control="all")
      # substitute(df)
      # levels(df[variable])
      # deparse(df[variable])
      parse(text=paste0(deparse(df), "$", deparse(variable)))
      paste0(deparse(df), "$", deparse(variable))
      # paste0(deparse(substitute(df)), "$", deparse(variable))
      # paste0(quote(deparse(df)), "$", deparse(variable))
      # call(paste0(deparse(df), "$", deparse(variable)))
      # deparse(df)
      # parse(substitute(df))
      # eval(paste0(deparse(df), "$", deparse(variable)))
      eval(deparse(df)[deparse(variable)])
      eval(expression(df))
      # eval(expression(df), envir=".GlobalEnv")
      call(expression(df))
}

check.levels(sheets[1])
check.levels(sheets_list[1])

################################################################################

poblacion_reclusa_1 <- read.csv("./varios/Población reclusa por CCAA, periodo, situación procesal-penal y sexo-UTF8.csv",
                                header=TRUE, skip=7, fileEncoding="UTF-8",
                                nrows=21, stringsAsFactors=FALSE)

# clean dataset
head(poblacion_reclusa_1)

# Tipo of reclusos
unique(as.character(poblacion_reclusa_1[1, ]))

# Some definitions
tipo <- c("total", "preventivos", "penados", "otros")
sexo <- c("ambos", "hombres", "mujeres")
year <- c(as.character(2000:2013))
comunidades <- c("Andalucia", "Aragon", "Asturias", "Baleares", "Canarias", 
                 "Cantabria", "Castilla_Leon", "Castilla_La_Mancha", "Cataluña", 
                 "C_Valenciana", "Extremadura", "Galicia", "Madrid", "Murcia", 
                 "Navarra", "Pais_Vasco", "Rioja", "Ceuta_Melilla")

# rep(year, length(rep(tipo))*length(rep(sexo)))
# paste0(rep(year, length(rep(tipo))*length(rep(sexo))), "_", rep(tipo, length(rep(year))*length(rep(sexo))))

# rep(year, each=length(rep(tipo))*length(rep(sexo)))
# rep(tipo, length(year), each=length(sexo))
# rep(sexo, length(tipo)*length(year))

variables <- paste0(rep(year, each=length(rep(tipo))*length(rep(sexo))), ".",
                    rep(tipo, length(year), each=length(sexo)), ".",
                    rep(sexo, length(tipo)*length(year)))

variables <- c("comunidad", variables)
names(poblacion_reclusa_1) <- variables

# Save totales to check it later
totales <- poblacion_reclusa_1[3, 2:169]

poblacion_reclusa_2 <- poblacion_reclusa_1[4:21, 2:169]
# row.names(poblacion_reclusa_2) <- poblacion_reclusa_1[4:21, 1]

# Change to list of comunidades autonomas
row.names(poblacion_reclusa_2) <- comunidades

rep(comunidades, length(sexo)*length(tipo)*length(year))

poblacion_reclusa_3 <- stack(poblacion_reclusa_2)
poblacion_reclusa <- data.frame(comunidad=rep(comunidades, length(sexo)*length(tipo)*length(year)),
                                year=     rep(year, each=length(comunidades)*length(tipo)*length(sexo)),
                                tipo=     rep(tipo, length(year), each=length(sexo)*length(comunidades)),
                                sexo=     rep(sexo, length(year)*length(tipo), each=length(comunidades)),
                                presos=   as.numeric(as.character(poblacion_reclusa_3[, 1])))

# save(poblacion_reclusa, file="poblacion_reclusa.RData")