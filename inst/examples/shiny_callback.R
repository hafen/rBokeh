library(shiny)
library(rbokeh)

ui = shinyUI(fixedPage(
  fixedRow(
    rbokehOutput("rbka")
  ),
  fixedRow(
    textOutput("rbka_callback")
  ),
  fixedRow(
    rbokehOutput("rbka_sub")
  )
))

server = function(input, output) {
  df_sub = data.frame()
  
  output$rbka <- renderRbokeh({
    df = data.frame(group = rep(c("a", "b"), 5), x = rnorm(10), y = rnorm(10))
    
    figure(xlab = "x", ylab = "y", xlim = c(-2, 2), ylim = c(-2, 2), 
           tools = c("lasso_select")) %>%
      ly_points(x, y, data = df) #, color = group) #, callback = list(x, y, group)) 
    #, url = "http://www.google.com?q=@group")
  })
  
  output$rbka_callback <- renderPrint({
    if (!is.null(input$rbka_callback))
      input$rbka_callback
  })
  
  output$rbka_sub <- renderRbokeh({
    if (!is.null(input$rbka_callback) && length(input$rbka_callback) > 0) {
      df2 = data.frame(do.call(rbind, lapply(input$rbka_callback, unlist)), stringsAsFactors = FALSE)
      df2$x = as.numeric(df2$x)
      df2$y = as.numeric(df2$y)
        
      print(df2)
      
      figure(xlab = "x", ylab = "y", xlim = c(-2, 2), ylim = c(-2, 2), title = "callback") %>%
        ly_points(x, y, data = df2)
    } else if (!is.null(input$rbka_select_callback) && length(input$rbka_select_callback) > 0) {
      df2 = data.frame(do.call(rbind, lapply(input$rbka_select_callback, unlist)), stringsAsFactors = FALSE)
      df2$x = as.numeric(df2$x)
      df2$y = as.numeric(df2$y)
      
      print(df2)
      
      figure(xlab = "x", ylab = "y", xlim = c(-2, 2), ylim = c(-2, 2), title = "select_callback") %>%
        ly_points(x, y, data = df2)
    } else {
      NULL
    }
  })
}

shinyApp(ui = ui, server = server)
