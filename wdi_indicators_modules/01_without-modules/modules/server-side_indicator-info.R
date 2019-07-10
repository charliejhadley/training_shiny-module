control_inputs <- function(input, output, session) {
  return(input)
}

renderIndicatorTimeline <- function(input, output, session, controls, data, selected_indicator) {
  output$indicator_timeline <- renderPlot({
    data %>%
      gg_wdi_indicator_timeline(
        controls$selected_country,
        selected_indicator
      )
  })
}

renderCountryComparison <- function(input, output, session, controls, data, selected_indicator) {
  output$indicator_info <- renderUI({
    
    most_recent_year <- wdi_data %>%
      filter(
        country == controls$selected_country,
        indicator == selected_indicator,
        !is.na(value)
      ) %>%
      pull(year) %>%
      max()

    ranking_table <- wdi_data %>%
      filter(
        indicator == selected_indicator,
        year == most_recent_year,
        !is.na(value)
      ) %>%
      arrange(desc(value)) %>%
      mutate(rank = row_number()) %>%
      select(rank, -iso2c, -indicator, -year, country, value)

    value_label <- wdi_indicators %>%
      filter(wdi_indicator_code == selected_indicator) %>%
      pull(wdi_indicator_name)

    country_rank <- ranking_table %>%
      filter(country == controls$selected_country) %>%
      pull(rank)


    tagList(
      p(paste0("The most recent data for the selected country - ", controls$selected_country, " - is from ", most_recent_year, ".")),
      p(paste("In this year, ", controls$selected_country, " at position ", country_rank, " out of ", nrow(ranking_table), ", see the table below for more details.")),

      ranking_table %>%
        datatable(
          options = list(
            pageLength = nrow(.),
            dom = "Bft",
            scrollY = "55vh"
          ),
          colnames = c("Rank", "Country", value_label),
          width = "100%",
          rownames = FALSE
        ) %>%
        formatStyle(
          "country",
          target = "row",
          backgroundColor = styleEqual(c(controls$selected_country), c("yellow"))
        ) %>%
        formatRound(
          "value",
          digits = 2
        ) %>%
        formatPercentage(
          "value",
          interval = 2,
          mark = "."
        )
    )
  })
}