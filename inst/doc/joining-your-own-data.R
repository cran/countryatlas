## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 4, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
library(dplyr)
has_sf <- requireNamespace("sf", quietly = TRUE) &&
  requireNamespace("rnaturalearth", quietly = TRUE) &&
  requireNamespace("rnaturalearthdata", quietly = TRUE)
# The polygon backend needs `maps`, which is only in Suggests, so every chunk
# that attaches or draws polygon geometry is guarded on this. Without it the
# vignette still builds -- it just skips those maps.
has_maps <- requireNamespace("maps", quietly = TRUE)

## -----------------------------------------------------------------------------
my_data <- data.frame(
  nation = c("U.S.", "S. Korea", "Czechia", "Kosovo", "Cote d'Ivoire", "UK"),
  score  = c(10, 8, 6, 4, 7, 9)
)
standardize_country(my_data, nation, warn = FALSE)

## ----eval = has_maps, fig.alt = "World choropleth of a user-supplied score column after joining to the ISO spine."----
my_data |>
  join_world(nation, warn = FALSE) |>
  world_map(score, title = "My data on the ISO spine")

## -----------------------------------------------------------------------------
a <- data.frame(country = c("Czechia", "South Korea", "Russia"), gdp = 1:3)
b <- data.frame(nation  = c("Czech Republic", "Korea, Rep.", "Russian Federation"),
                pop = c(10, 51, 144))
country_join(a, b, country, nation)

## -----------------------------------------------------------------------------
t1 <- data.frame(country = c("Czechia", "South Korea"), gdp = c(1, 2))
t2 <- data.frame(country = c("Czech Republic", "Korea, Rep."), pop = c(10, 51))
t3 <- data.frame(country = c("Czechia", "Korea"), area = c(79, 100))
country_join_all(list(t1, t2, t3), by = "country")

## -----------------------------------------------------------------------------
check_country_match(my_data$nation)

## -----------------------------------------------------------------------------
check_country_match(c("USSR", "Yugoslavia", "West Germany"))
dissolve_country(c("Czechoslovakia", "France"))

## -----------------------------------------------------------------------------
fixed <- repair_country_names(c("Brzil", "Nehterlands", "United States"),
                              verbose = FALSE)
fixed

## -----------------------------------------------------------------------------
country_overrides(c(Somaliland = "SOM"))[c("Kosovo", "Somaliland")]

## -----------------------------------------------------------------------------
df <- data.frame(code = c("US", "KR", "BR"))
standardize_country(df, code, origin = "iso2c", warn = FALSE)

## ----eval = has_sf------------------------------------------------------------
locate_country(lon = c(2.35, -74.0, 139.7), lat = c(48.85, 40.7, 35.7))

