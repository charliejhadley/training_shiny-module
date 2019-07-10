library("DT")
library("english")

source("data-processing.R", local = TRUE)

function(input, output, session) {
  
  ## ==== Internet users ====
  
  output$internet_users_timeline <- renderPlot({
    wdi_data %>%
      gg_wdi_indicator_timeline(
        input$internet_country,
        "IT.NET.USER.ZS"
      )
  })

  output$internet_users_ranking_table <- renderUI({
    most_recent_year <- wdi_data %>%
      filter(
        country == input$internet_country,
        indicator == "IT.NET.USER.ZS",
        !is.na(value)
      ) %>%
      pull(year) %>%
      max()

    print("here")

    ranking_table <- wdi_data %>%
      filter(
        indicator == "IT.NET.USER.ZS",
        year == most_recent_year,
        !is.na(value)
      ) %>%
      arrange(desc(value)) %>%
      mutate(rank = row_number()) %>%
      select(rank, -iso2c, -indicator, -year, country, value)

    value_label <- wdi_indicators %>%
      filter(wdi_indicator_code == "IT.NET.USER.ZS") %>%
      pull(wdi_indicator_name)

    country_rank <- ranking_table %>%
      filter(country == input$internet_country) %>%
      pull(rank)


    tagList(
      p(paste0("The most recent data for the selected country - ", input$internet_country, " - is from ", most_recent_year, ".")),
      p(paste0("In this year, ", input$internet_country, " was at position ", country_rank, " out of ", nrow(ranking_table), ", see the table below for more details.")),

      ranking_table %>%
        datatable(
          options = list(
            pageLength = nrow(.),
            dom = "Bft"
          ),
          colnames = c("Rank", "Country", value_label),
          width = "100%",
          height = "1000px",
          rownames = FALSE
        ) %>%
        formatStyle(
          "country",
          target = "row",
          backgroundColor = styleEqual(c(input$internet_country), c("yellow"))
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

  ## ==== BANK BRANCHES ====

  output$bank_branches_timeline <- renderPlot({
    wdi_data %>%
      gg_wdi_indicator_timeline(
        input$bank_branches_country,
        "FB.CBK.BRCH.P5"
      )
  })


  output$bank_branches_ranking_table <- renderUI({
    most_recent_year <- wdi_data %>%
      filter(
        country == input$bank_branches_country,
        indicator == "FB.CBK.BRCH.P5",
        !is.na(value)
      ) %>%
      pull(year) %>%
      max()

    ranking_table <- wdi_data %>%
      filter(
        indicator == "FB.CBK.BRCH.P5",
        year == most_recent_year,
        !is.na(value)
      ) %>%
      arrange(desc(value)) %>%
      mutate(rank = row_number()) %>%
      select(rank, -iso2c, -indicator, -year, country, value)

    value_label <- wdi_indicators %>%
      filter(wdi_indicator_code == "FB.CBK.BRCH.P5") %>%
      pull(wdi_indicator_name)

    country_rank <- ranking_table %>%
      filter(country == input$bank_branches_country) %>%
      pull(rank)


    tagList(
      p(paste0("The most recent data for the selected country - ", input$bank_branches_country, " - is from ", most_recent_year, ".")),
      p(paste0("In this year, ", input$bank_branches_country, " was at position ", country_rank, " out of ", nrow(ranking_table), ", see the table below for more details.")),

      ranking_table %>%
        datatable(
          options = list(
            pageLength = nrow(.),
            dom = "Bft"
          ),
          colnames = c("Rank", "Country", value_label),
          width = "100%",
          height = "1000px",
          rownames = FALSE
        ) %>%
        formatStyle(
          "country",
          target = "row",
          backgroundColor = styleEqual(c(input$bank_branches_country), c("yellow"))
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