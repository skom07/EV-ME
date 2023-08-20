library(shiny)
library(tidyverse)
library(leaflet)
library(shinyjs)  # Load the shinyjs package

addResourcePath("images", "D:/USC/3rd Year/SEM 2/ENG 304/GovHack/R Shiny/www/")

ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  
  tags$head(
    tags$style(
      HTML('
        body {
          background-image: url("images/bg2.jpg");
          background-size: cover;
          background-repeat: no-repeat;
          background-attachment: fixed;
          color: white; /* Set text color to white */
        }
        .main-title {
          font-family: "Arial", sans-serif;
          font-size: 48px;
          color: white; /* Set title font color to white */
          text-align: center;
          padding: 20px;
          border-bottom: 2px solid #34495E;
          text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        /* Add more custom styles here */
      ')
    )
  ),
  titlePanel(
    h1(class = "main-title", "EV-ME.beta")
  ),
  textInput(inputId = "VehicleRegistration",
            label = "",
            value = "",
            placeholder = "Registration"),
  actionButton(inputId = "ChargingStationsButton", label = "Available Charging Stations"),
  leafletOutput("map"),  # Output for displaying the map
  selectInput(inputId = "Bookings",
              label = "Make a Booking",
              choices = list(Location1 = "Location 1",
                             Location2 = "Location 2")),
  actionButton(inputId = "MoreInfoButton", label = "More Info"),
  actionButton(inputId = "QuitButton", label = "Quit")
)

server <- function(input, output) {
  map_open <- FALSE  # To keep track of whether the map is open or collapsed
  
  observeEvent(input$ChargingStationsButton, {
    if (!map_open) {
      output$map <- renderLeaflet({
        map_open <<- TRUE  # Update map_open status
        leaflet() %>%
          addTiles() %>%  # Add base map tiles
          setView(lng = 149.128684, lat = -35.282001, zoom = 10)  # ACT coordinates and zoom level
      })
    } else {
      output$map <- renderLeaflet(NULL)  # Collapse the map
      map_open <<- FALSE  # Update map_open status
    }
  })
  
  observeEvent(input$MoreInfoButton, {
    # Open the link in the default browser
    shinyjs::runjs('console.log("Opening link..."); window.open("https://evme.zohosites.com.au/", "_blank");')
  })
  
  
  
  observeEvent(input$QuitButton, {
    # Perform actions when the "Quit" button is clicked
    stopApp()
  })
}

shinyApp(ui = ui, server = server)

