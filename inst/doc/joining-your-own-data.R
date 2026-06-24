## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 4, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
library(dplyr)

## -----------------------------------------------------------------------------
my_data <- data.frame(
  nation = c("U.S.", "S. Korea", "Czechia", "Kosovo", "Cote d'Ivoire", "UK"),
  score  = c(10, 8, 6, 4, 7, 9)
)
standardize_country(my_data, nation, warn = FALSE)

## -----------------------------------------------------------------------------
my_data |>
  join_world(nation, warn = FALSE) |>
  world_map(score, title = "My data on the ISO spine")

## -----------------------------------------------------------------------------
a <- data.frame(country = c("Czechia", "South Korea", "Russia"), gdp = 1:3)
b <- data.frame(nation  = c("Czech Republic", "Korea, Rep.", "Russian Federation"),
                pop = c(10, 51, 144))
country_join(a, b, country, nation)

## -----------------------------------------------------------------------------
check_country_match(my_data$nation)

## -----------------------------------------------------------------------------
wdj_overrides(c(Somaliland = "SOM"))[c("Kosovo", "Somaliland")]

## -----------------------------------------------------------------------------
df <- data.frame(code = c("US", "KR", "BR"))
standardize_country(df, code, origin = "iso2c", warn = FALSE)

