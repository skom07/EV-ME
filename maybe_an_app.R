library(shiny)
library(tidyverse)

setwd("D:/USC/3rd Year/SEM 2/ENG 304/GovHack/R Shiny/")


 ui <- fluidPage(textInput(inputId = "EV-ME",
                           label = "EV-ME",
                           value = "",
                           placeholder = "Registration"),
                 selectInput(inputId = "Locations",
                             label = "Location",
                             choices = list(Gayberhood = "Gayberhood",
                                            Somting = "Someting")))
 server <- function(input, output) {}
 shinyApp(ui = ui, server = server)
    