require(shiny)
require(rCharts)

shinyServer(function(input, output) {
  
  output$tab_container_1 <- renderChart2({
    
    print(input$slider1)
    print(input$slider1)
    print(input$slider1[1])
    print(input$slider1[2])
    
    data <- getData(input$slider1[1], input$slider1[2])  
    
    chart <- mPlot(x = 'year', 
                   y = 'presos', 
                   type = 'Line',
                   data = data)
    
    chart$set(pointSize = 0, lineWidth = 1)    
    
    chart
  })
  
})
