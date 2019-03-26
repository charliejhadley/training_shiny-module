library("shiny")
library("shinycustomloader")

shinyServer(navbarPage(
  "Shiny without Modules",
  tabPanel(
    "By occupation",
    fluidPage(fluidRow(column(
      radioButtons(
        "by_occupation_landing_rollmean_k",
        label = "",
        choices = list(
          "Show daily value" = 1,
          "Show 28-day moving average" = 28
        ),
        selected = 28,
        inline = TRUE
      ),
      width = 12
    )),
    withLoader(plotOutput("gg_gigs_by_occupation")),
    type = "html", loader = "dnaspin"
    )
  ),
  tabPanel(
    "By country",
    fluidPage(fluidRow(column(
      radioButtons(
        "by_country_group_landing_rollmean_k",
        label = "",
        choices = list(
          "Show daily value" = 1,
          "Show 28-day moving average" = 28
        ),
        selected = 28,
        inline = TRUE
      ),
      width = 12
    )),
    withLoader(plotOutput("gg_gigs_by_country_group")),
    type = "html", loader = "dnaspin"
    )
  )
))