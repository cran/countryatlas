## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 4, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
snap <- world_snapshot$countries

## -----------------------------------------------------------------------------
bubble_map(snap, population)

## ----fig.height = 5-----------------------------------------------------------
tile_map(snap, gdp_per_capita)

## -----------------------------------------------------------------------------
od <- data.frame(
  from   = c("China", "Germany", "Brazil", "Nigeria"),
  to     = c("United States", "France", "Argentina", "India"),
  weight = c(500, 200, 90, 60)
)
flow_map(od, from, to, weight)

## -----------------------------------------------------------------------------
mapdf <- attach_geometry(
  dplyr::filter(snap, continent == "Europe"), geometry = "polygon"
)
world_map(mapdf, gdp_per_capita) +
  geom_country_labels(repel = FALSE, size = 2.5) +
  ggplot2::coord_cartesian(xlim = c(-25, 45), ylim = c(34, 72))

## ----eval = FALSE-------------------------------------------------------------
# # Bivariate choropleth (two variables at once) — needs `biscale` + `sf`
# world_data(2020, c(gdp = "NY.GDP.PCAP.KD", life = "SP.DYN.LE00.IN"),
#            geometry = "sf") |>
#   bivariate_map(gdp, life)
# 
# # Area-honest cartogram — needs `cartogram` + `sf`
# world_data(2020, c(pop = "SP.POP.TOTL"), geometry = "sf") |>
#   cartogram_map(pop, type = "dorling")
# 
# # Animated choropleth over a year panel — needs `gganimate`
# world_data(2000:2020, c(gdp = "NY.GDP.PCAP.KD")) |>
#   animate_world(gdp)
# 
# # Interactive choropleth — needs `leaflet`, `ggiraph` or `plotly`
# world_data(2020) |>
#   interactive_map(gdp_per_capita, engine = "plotly")

