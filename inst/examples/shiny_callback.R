library(shiny)
library(rbokeh)

df = data.frame(group = rep(c("a", "b"), 5), x = rnorm(10), y = rnorm(10))

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
  output$rbka <- renderRbokeh({
    figure(xlab = "x", ylab = "y", xlim = c(-2, 2), ylim = c(-2, 2)) %>%
      ly_points(x, y, data = df, color = group) #, callback = list(x, y, group)) 
    #, url = "http://www.google.com?q=@group")
  })
  
  output$rbka_callback <- renderPrint({
    if (!is.null(input$rbka_callback))
      input$rbka_callback
  })
  
  output$rbka_sub <- renderRbokeh({
    if (!is.null(input$rbka_callback)) {
      print(input$rbka_callback)
      figure(xlab = "x", ylab = "y", xlim = c(-2, 2), ylim = c(-2, 2)) %>%
        ly_points(x, y, data = df[df$group == input$rbka_callback$group, ],
                  color = group)
    }
  })
}

shinyApp(ui = ui, server = server)