library("shiny")
library("tidyverse")
library("rfigshare")
library("lubridate")
library("xts")
library("ggsci")

source("data-processing.R", local = TRUE)

source("gg_ma_timeseries.R", local = TRUE)

function(input, output, session) {
  output$gg_gigs_by_occupation <- renderPlot({
    gigs_by_occupation %>%
      group_by(occupation) %>%
      arrange(date) %>%
      mutate(jobs = rollmean(jobs,
        k = as.numeric(input$by_occupation_landing_rollmean_k),
        na.pad = TRUE,
        align = "right"
      )) %>%
      filter(!is.na(jobs)) %>%
      ungroup() %>%
      gg_ma_timeseries(date, jobs, occupation)
  })

  output$gg_gigs_by_country_group <- renderPlot({
    gigs_by_country_group %>%
      group_by(country_group) %>%
      arrange(date) %>%
      mutate(jobs = rollmean(jobs,
        k = as.numeric(input$by_country_group_landing_rollmean_k),
        na.pad = TRUE,
        align = "right"
      )) %>%
      filter(!is.na(jobs)) %>%
      ungroup() %>%
      gg_ma_timeseries(date, jobs, country_group)
  })
}