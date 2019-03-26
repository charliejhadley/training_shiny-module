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
      ma_job_count(date, jobs, occupation, input$by_occupation_landing_rollmean_k) %>%
      gg_ma_timeseries(date, jobs, occupation)
    
  })

  output$gg_gigs_by_country_group <- renderPlot({
    
    gigs_by_country_group %>%
      ma_job_count(date, jobs, country_group, input$by_country_group_landing_rollmean_k) %>%
      gg_ma_timeseries(date, jobs, country_group)
    
  })
}
