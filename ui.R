shinyUI(fluidPage(

  mainPanel(
    ggvisOutput("ggvis"),
    dataTableOutput("runs")
  )
  
))