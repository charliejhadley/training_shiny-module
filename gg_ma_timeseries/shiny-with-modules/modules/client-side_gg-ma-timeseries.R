library("shinycustomloader")

gg_ma_timeseries_input <- function(id) {
  ns <- NS(id)
  tagList(
    "This entire tab is a shiny module, including; this text, the radio buttons and the chart.",
    fluidRow(column(
      radioButtons(
        ns("landing_rollmean_k"),
        label = "",
        choices = list(
          "Show daily value" = 1,
          "Show 28-day moving average" = 28
        ),
        selected = 28,
        inline = TRUE
      ),
      width = 12
    ))
  )
}

gg_ma_timeseries_output <- function(id) {
  ns <- NS(id)
  withLoader(plotOutput(ns("ma_plot")), type = "html", loader = "dnaspin")
}