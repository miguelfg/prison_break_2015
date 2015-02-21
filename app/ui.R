
shinyUI(pageWithSidebar( 
  
  headerPanel("Prison Break - Encarcelados en España"),
  
  sidebarPanel(
    "Juega con los datos!", 
    sliderInput("slider1", "",
                min = 2000, max = 2014, value = c(2010, 2014), ticks = FALSE, sep = ''
    ),
    
    radioButtons("factor", "Elige grupo:",
                 c("año" = "year",
                   "comunidad" = "comunidad"),
                 selected='year'
     )
  ),
   
  mainPanel(
    tabsetPanel(
      
      tabPanel("Tasa de encarcelados por comunidades", 
#                includeMarkdown("texts/desc_table.md"),
               chartOutput("tab_container_1", 'morris')
      ),
      
      tabPanel("Gráfica ..", 
               showOutput("tab_container_2", 'polycharts')
      ),
      tabPanel("Tabla de encarcelados por población", 
               #                includeMarkdown("texts/desc_table.md"),
               dataTableOutput("tab_container_0")
      )
#       ,

#       ,
#       tabPanel("blabla", 
#                 showOutput("tab_container_3", 'dimple')
#       )
#       ,

#       tabPanel("balbla", includeMarkdown("texts/desc_table.md"))
    )
  )
  
))

