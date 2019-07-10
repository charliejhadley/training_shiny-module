library("WDI")
library("tidyverse")
library("gapminder")
library("countrycode")

countries_tib <- gapminder %>%
  select(country, continent) %>%
  unique() %>%
  rename(name = country) %>%
  mutate_if(is.factor, as.character) %>%
  mutate(iso2c = countrycode(name,
                             "country.name",
                             "iso2c"))

wdi_indicators <- tribble(
  ~wdi_indicator_code, ~wdi_indicator_name, ~wdi_indicator_y_axis,
  "IT.NET.USER.ZS", "Individuals using the Internet (% of population)", "% of population",
  "FB.CBK.BRCH.P5", "Commercial bank branches (per 100,000 adults)", "Branches per 100,000 adults",
  "SE.SEC.ENRL", "Children in secondary education", "Children in school"
)


wdi_data <- WDI(country = countries_tib$iso2c, indicator = wdi_indicators$wdi_indicator_code) %>%
  as_tibble() %>%
  gather(indicator, value, 4:ncol(.))

countries_with_missing_series <- wdi_data %>%
  group_by(country,
           indicator) %>%
  summarise(total = sum(value, na.rm = TRUE)) %>%
  filter(total == 0) %>%
  pull(country)

wdi_data <- wdi_data %>%
  filter(!country %in% countries_with_missing_series)

gg_wdi_indicator_timeline <- function(data,
                                      selected_country, 
                                      selected_indicator){
  y_axis_label <- wdi_indicators %>%
    filter(wdi_indicator_code == selected_indicator) %>%
    pull(wdi_indicator_y_axis)
  
  chart_title <- wdi_indicators %>%
    filter(wdi_indicator_code == selected_indicator) %>%
    pull(wdi_indicator_name)
  
  data %>%
    filter(country == selected_country) %>%
    filter(indicator == selected_indicator) %>%
    filter(!is.na(value)) %>%
    ggplot(aes(x = year,
               y = value)) +
    geom_line() +
    labs(title = chart_title,
         x = "", 
         y = y_axis_label)
    
}