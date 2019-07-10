library("shinycustomloader")

indicator_country_input <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("selected_country"),
                "Select a country",
                choices = c())
    
  )
}

indicator_country_timeline_output <- function(id) {
  ns <- NS(id)
  plotOutput(ns("indicator_timeline"))
}

indicator_country_UI_output <- function(id) {
  ns <- NS(id)
  uiOutput(ns("indicator_info"))
}