library(shiny)
library(ggvis)

r4t <- read.csv("data/runs400.top_2014.csv")
runsTable <- r4t[, c(8:9, 4, 6, 15)]
runsTable <- runsTable[order(-runsTable$Runs.Created), ]

