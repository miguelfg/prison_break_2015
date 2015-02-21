require(shiny)

shinyUI(pageWithSidebar( 
  
  headerPanel("Prison Break 2015"),
  
  sidebarPanel(
    "Juega con los datos!", 
    # Num of measure traffic points
    sliderInput("slider1", "",
                min = 2000, max = 2014, value = c(2010, 2014))
  ),
   
  mainPanel(
    tabsetPanel(
      tabPanel("blabla", 
               includeMarkdown("texts/desc_table.md"),
               chartOutput("tab_container_1", 'morris')
      ),
      tabPanel("balbla", includeMarkdown("texts/desc_table.md"))
    )
  )
  
))

