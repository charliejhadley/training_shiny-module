gg_ma_timeseries <- function(.data, date, value, category) {
  date <- enquo(date)
  
  value <- enquo(value)
  
  category <- enquo(category)
  
  n_colours <- .data %>%
    pull(!!category) %>%
    unique() %>%
    length()
  
  colours_from_startrek <- colorRampPalette(pal_startrek(palette = c("uniform"))(7))(n_colours)
  
  
  .data %>%
    ggplot(aes(
      x = !!date,
      y = !!value,
      color = !!category
    )) +
    geom_line() +
    theme_bw() +
    scale_color_manual(values = colours_from_startrek) +
    scale_x_date(expand = c(0.01, 0.01)) +
    scale_y_continuous(expand = c(0.01, 0)) +
    labs(
      title = "Example dataviz of Online Labour Index data",
      subtitle = "DOI:10.6084/m9.figshare.376156")
}