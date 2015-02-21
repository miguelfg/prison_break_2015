
shinyServer(function(input, output) {
  
  getDataYears <- reactive({
    data <- getData(input$slider1[1], input$slider1[2])  
    data
  })
  
  output$tab_container_0 <-  renderDataTable({    
    data <- getDataYears()
    
  }, options = list(lengthMenu = c(10, 15, 30, 50), 
                    iDisplayLength = 10,
                    search = list(regex = TRUE)
  ),
  searchDelay = 500)
  
  output$tab_container_1 <- renderChart2({

    data <- getDataYears()
    chart <- mPlot(x = 'year', 
                   y = 'presos', 
                   type = 'Bar',
#                    group = "year",
                   labels = list('% encarcelados x 10mil habs'),
                   data = data)
    
#     chart$set(pointSize = 0, lineWidth = 1)    
#     chart$set(xLabelFormat = "#! function (x) { 
#       return x.toString(); } 
#     !#")

    chart
  })

  output$tab_container_2 <- renderChart2({
    
    data <- getDataYears()
    selected_group <- input$factor
    print(selected_group)
    
    p1 <- rPlot(tasa ~ comunidad | year, data = data, color = 'comunidad', type = 'point')
#     p1 <- rPlot(tasa ~ comunidad, color = 'comunidad', data = data, type = 'bar')
#     p1 <- rPlot(x = 'comunidad', y = 'tasa', data = data, type = 'box')
#     p1$facet(var = 'tasa', type = 'wrap', rows = 2)
    p1
  })

  output$tab_container_3 <- renderChart2({
    
    data <- getDataYears()
    selected_group <- input$factor
    print(selected_group)
    
    p1 <- rPlot(x = 'comunidad', y = 'tasa', data = data, type = 'box')
    p1
  })

})
