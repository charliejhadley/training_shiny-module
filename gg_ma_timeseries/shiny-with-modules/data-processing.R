fs_deposit_id <- 3761562
deposit_details <- fs_details(fs_deposit_id)

deposit_details <- unlist(deposit_details$files)
deposit_details <-
  data.frame(split(deposit_details, names(deposit_details)), stringsAsFactors = F)

imported_country_group_data <- deposit_details %>%
  filter(str_detect(name, "bcountrydata_")) %>%
  pull(download_url) %>%
  read_csv() %>%
  mutate(timestamp = as_date(timestamp)) %>%
  rename(date = timestamp)

gigs_by_country_group <- imported_country_group_data %>%
  group_by(date, country_group) %>%
  summarise(jobs = sum(count)) %>%
  ungroup()

gigs_by_occupation <- imported_country_group_data %>%
  group_by(date, occupation) %>%
  summarise(count = sum(count)) %>%
  rename(jobs = count) %>%
  ungroup()

