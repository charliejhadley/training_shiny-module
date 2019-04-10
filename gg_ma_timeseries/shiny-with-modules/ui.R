library("shiny")

source("modules/client-side_gg-ma-timeseries.R", local = TRUE)

shinyServer(navbarPage(
  "Shiny Modules",
  tabPanel(
    "By occupation",
    fluidPage(
      gg_ma_timeseries_input("occupation_controls"),
      gg_ma_timeseries_output("occupation_chart")
    )
  ),
  tabPanel(
    "By country",
    fluidPage(
      gg_ma_timeseries_input("by_country_controls"),
      gg_ma_timeseries_output("by_country_chart")
    )
  )
))