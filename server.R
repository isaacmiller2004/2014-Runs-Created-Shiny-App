shinyServer(function(input, output){
  all_values <- function(x) {
    if(is.null(x)) return(NULL)
    row <- r4t[r4t$id == x$id, ]
    if (is.null(row$Last.Name)) return(NULL)
    paste0("<b>", row$First.Name, " ", row$Last.Name, "</b>", 
           "<br />", "Runs Created: ", round(row$Runs.Created, 2),
           "<br />", "Potential Runs: ", round(row$Runs.Potential, 2),
           "<br />", "Percent: " , round(row$Runs.Created/row$Runs.Potential * 100, 2), "%")
  }
    
  r4t %>% ggvis(~Runs.Potential, ~Runs.Created) %>%
    layer_points(stroke := "#C60C30", fill := "#C60C30", key := ~id, 
                 size.hover := 200, stroke.hover := "black") %>%
    layer_model_predictions(model = "lm", formula = Runs.Created ~ Runs.Potential) %>%
    add_axis("x", title = "Potential Runs") %>%
    add_axis("y", title = "Runs Created") %>%
    add_axis("x", orient = "top", ticks = 0, title = "2014 RUNS CREATED",
             properties = axis_props(
               axis = list(stroke = "white"),
               title = list(fontSize = 24),
               labels = list(fontSize = 0))) %>%
    add_tooltip(all_values, "hover") %>%
    set_options(width = 800, height = 450) %>%
    bind_shiny("ggvis") 
  
  output$runs <- renderDataTable(
    runsTable,
    option = list( drawCallback = 
                     I("function( settings ) {document.getElementById('runs').style.width = '850px';}")) )

})
