library("shiny")
library("xts")
library("tidyverse")
library("rfigshare")
library("lubridate")
library("ggsci")

source("data-processing.R", local = TRUE)

source("gg_ma_timeseries.R", local = TRUE)

source("modules/server-side_gg-ma-timeseries.R", local = TRUE)

function(input, output, session) {
  occupation_controls <- callModule(
    control_inputs,
    "occupation_controls"
  )

  callModule(
    gg_ma_timeseries_output,
    "occupation_chart",
    occupation_controls,
    gigs_by_occupation,
    jobs,
    occupation
  )

  by_country_controls <- callModule(
    control_inputs,
    "by_country_controls"
  )

  callModule(
    gg_ma_timeseries_output,
    "by_country_chart",
    by_country_controls,
    gigs_by_country_group,
    jobs,
    country_group
  )
}