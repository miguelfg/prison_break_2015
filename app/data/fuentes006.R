# Parte de proyecto "¿Por qué España está en el top5 europeo de población encarcelada?
# Pedro Concejero 2015

# Objetivo: cargar y comentar los diferentes datasets remitidos por Santiago Mota y otros compis equipo
# *NO* se describe cómo se han obtenido, sino lo que contienen y las posibilidades que ofrecen

#####
# Cargamos algunas librerías, pa grafiquitos etc
library(ggplot2)
library(gtools)
library(stringr)

#######
# 1 World_2010 contiene datos de 113 países sobre gente en prisión
# obtenido de http://www.unodc.org/documents/data-and-analysis/statistics/crime/CTS12_Persons_detained.xls

load("world_2010.RData")
summary(world_2010)
nrow(world_2010)

# Por ejemplo datos de España

spain <- world_2010[world_2010$Country.territory == "Spain", -1 ]

zz <- as.table(spain)
zz <- as.table(as.matrix(spain))
barplot(zz)

# No es muy ilustrativo porque las categorías no son mut. exclusivas
# sí que podemos sacar ratios

prop.mujeres <- spain$female_adults_held/spain$total_persons_held
prop.hombres <- spain$male_adults_held/spain$total_persons_held
prop.juveniles <- spain$juveniles_held/spain$total_persons_held
prop.extranjeros <- spain$foreign_citizents/spain$total_persons_held
print(paste("prop. mujeres de total", prop.mujeres))
print(paste("prop.hombres de total", prop.hombres))

# no suman 100 porque faltan los jóvenes
print(paste("prop.juveniles de total, ambos sexos", prop.juveniles))

# verificamos suma 1
prop.mujeres + prop.hombres + prop.juveniles
# pues no... pero no hay otra categoría con ese 1.2% faltante

# y extranjeros
print(paste("prop.extran de total, ambos sexos", prop.extranjeros))

########
# Primeras conclusiones:
# Ojo datos 2010
# estar en prisión es cosa de hombres (casi 13 a 1)
0.89/0.07

# proporción de extranjeros encarcelados es muy considerable, un 35%
# ¿cuál es proporción oficial de extranjeros contra población total?
# pero estos datos no son suficientemente buenos porque ya están agregados
# no podemos por ejemplo saber la proporción de hombres/mujeres extranjeros


########
# 2. poblacion_reclusa.RData
# obtenida mediante script fuentes006.R -segunda parte
# Ojo! datos (presos) en filas (comunidad x año x tipo x sexo)
# necesario reshape
# tenemos hasta 2013!!!

load("poblacion_reclusa.RData")

summary(poblacion_reclusa)

table(poblacion_reclusa$year)

total <- poblacion_reclusa[poblacion_reclusa$tipo == "total" &
                             poblacion_reclusa$sexo == "ambos",]

total2 <- reshape(total[,c(1,2,5)],
                  idvar = "comunidad",
                  timevar = "year",
                  direction = "wide")

# Wait! se puede usar en formato "long" con ggplot

ggplot(data=total, 
       aes(x=year, 
           y=presos, 
           group = comunidad, 
           colour = comunidad)) +
  geom_line() +
  geom_point( size=4, shape=21, fill="white")


#########
# Conclusiones preliminares
# ¡Qué bueno! 
# crisis ha producido descenso de total en prisiones
# picos en comunidades mas pobladas en 2009
# Ojo ojo ojo ojo población en prisiones en comunidad aut. no quiere decir
# que delito se haya producido en comunidad autónoma
# Aunque tendrá que ver con origen de recluso... Digo yo
# Andalucía tiene x2 población reclusa de siguiente (Cataluña)

# Hay que arreglar:
# Llevar datos a proporción población total
# (merge con datos población por com. autónoma si es posible por año)
# arreglar colores en gráfico
# mezclar con datos socioeconómicos: PIB, paro...

##########
# 3. Datos de INE
# ingestados en fuentes005.R

load("ine_02003.RData")
load("ine_02005.RData")
load("ine_02006.RData")

table(ine_02003$Año)
table(ine_02005$Año)
table(ine_02006$Año)

# todos tienen datos 1998-2014
# ine_02006 tienen población total por sexo y total, español o extr
# ine_02005
# problema para cruzar son nombres de comunidades

ine_02006$comunidad <- word(tolower(ine_02006$comunidades),
                             start = 1, 
                             sep = ",")

ine_02006$comunidad <- gsub("`|\\'", "", 
                            iconv((ine_02006$comunidad), 
                                  to="ASCII//TRANSLIT")) 
table(ine_02006$comunidad)

total$comunidad <- tolower(total$comunidad) 
table(total$comunidad)

# aun así hay que hacer cosas a manopla -en ine_02006

ine_02006$comunidad[ine_02006$comunidad == "balears"] <- "baleares"
ine_02006$comunidad[ine_02006$comunidad == "comunitat valenciana"] <- "c_valenciana"
ine_02006$comunidad[ine_02006$comunidad == "castilla - la mancha"] <- "castilla_la_mancha"
ine_02006$comunidad[ine_02006$comunidad == "castilla y leon"] <- "castilla_leon"
ine_02006$comunidad[ine_02006$comunidad == "cataluna"] <- "catalunya"
total$comunidad[total$comunidad == "cataluña"] <- "catalunya"
ine_02006$comunidad[ine_02006$comunidad == "pais vasco"] <- "pais_vasco"

table(ine_02006$comunidad)
table(total$comunidad)

save.image(file = "prisons_wkspace.RData")

