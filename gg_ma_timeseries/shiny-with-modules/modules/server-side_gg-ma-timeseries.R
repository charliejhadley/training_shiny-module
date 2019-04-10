gg_ma_timeseries_output <- function(input, output, session, controls, data, value, category) {
  date <- enquo(date)
  value <- enquo(value)
  category <- enquo(category)

  output$ma_plot <- renderPlot({
    data %>%
      ma_job_count(date, !!value, !!category, controls$landing_rollmean_k) %>%
      gg_ma_timeseries(date, !!value, !!category)
  })
}

control_inputs <- function(input, output, session) {
  return(input)
}
