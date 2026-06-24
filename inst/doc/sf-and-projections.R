## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 4, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
has_sf <- requireNamespace("sf", quietly = TRUE) &&
  requireNamespace("rnaturalearth", quietly = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# install.packages(c("sf", "rnaturalearth", "rnaturalearthdata"))

## ----eval = FALSE-------------------------------------------------------------
# world_data(2020, c(gdp = "NY.GDP.PCAP.KD"), geometry = "sf") |>
#   world_map(gdp, style = "quantile", projection = "equal_earth",
#             title = "GDP per capita (Equal Earth projection)")

## ----eval = has_sf------------------------------------------------------------
# africa <- world_geometry("countries", geometry = "sf", region = "Africa",
#                          projection = "equal_earth")
# ggplot(africa) +
#   geom_sf(fill = "grey85", colour = "grey40", linewidth = 0.1) +
#   theme_world_map()

## ----eval = !has_sf, echo = FALSE, results = "asis"---------------------------
cat("> The live `sf` map is not shown because `sf` is not installed in this build.\n")

## ----eval = FALSE-------------------------------------------------------------
# world_geometry("countries", geometry = "sf", recenter = 150)

## ----eval = FALSE-------------------------------------------------------------
# world_geometry(geometry = "sf", scale = "large") |>
#   simplify_geometry(keep = 0.1)

