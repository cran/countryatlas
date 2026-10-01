## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 4, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
snap <- world_snapshot$countries
# The sf geometry backend needs all three, which is what need_pkg() gates
# on in geometry.R: sf alone is not enough, and a chunk guarded on sf
# alone fails the vignette build wherever the data packages are absent.
has_maps <- requireNamespace("maps", quietly = TRUE)
has_sf <- requireNamespace("sf", quietly = TRUE) &&
  requireNamespace("rnaturalearth", quietly = TRUE) &&
  requireNamespace("rnaturalearthdata", quietly = TRUE)

## ----eval = has_maps, fig.alt = "Bubble map: population drawn as proportional circles at country centroids."----
bubble_map(snap, population)

## ----eval = has_maps, fig.alt = "Spike map: population drawn as vertical spikes rising from country centroids."----
spike_map(snap, population)

## ----eval = has_maps----------------------------------------------------------
cov <- attr(suppressWarnings(bubble_map(snap, population)),
            "countryatlas_provenance")$coverage
unlist(cov[c("n_total", "n_shown", "n_missing")])
cov$missing_iso3c

## ----fig.height = 5, fig.alt = "Equal-area tile grid: one identically sized tile per country, shaded by GDP per capita."----
tile_map(snap, gdp_per_capita)

## ----eval = has_maps, fig.alt = "Flow map: great-circle arcs joining four origin-destination country pairs, width by volume."----
od <- data.frame(
  from   = c("China", "Germany", "Brazil", "Nigeria"),
  to     = c("United States", "France", "Argentina", "India"),
  weight = c(500, 200, 90, 60)
)
flow_map(od, from, to, weight)

## ----eval = has_maps, fig.height = 5, fig.alt = "Small multiples: one GDP per capita choropleth panel per continent."----
world_poly <- attach_geometry(snap, geometry = "polygon") |>
  dplyr::filter(!is.na(continent))
facet_map(world_poly, gdp_per_capita, continent, style = "quantile", ncol = 3)

## ----eval = has_maps, fig.alt = "Choropleth of Europe with ISO codes labelled at country centroids."----
mapdf <- attach_geometry(
  dplyr::filter(snap, continent == "Europe"), geometry = "polygon"
)
world_map(mapdf, gdp_per_capita) +
  geom_country_labels(repel = FALSE, size = 2.5) +
  ggplot2::coord_quickmap(xlim = c(-25, 45), ylim = c(34, 72))

## ----eval = FALSE-------------------------------------------------------------
# # Bivariate choropleth (two variables at once): needs `biscale` + `sf`
# world_data(2020, c(gdp = "NY.GDP.PCAP.KD", life = "SP.DYN.LE00.IN"),
#            geometry = "sf") |>
#   bivariate_map(gdp, life)
# 
# # Area-honest cartogram: needs `cartogram` + `sf`
# world_data(2020, c(pop = "SP.POP.TOTL"), geometry = "sf") |>
#   cartogram_map(pop, type = "dorling")
# 
# # The same Dorling cartogram as a first-class verb, with its tuning exposed
# world_data(2020, c(pop = "SP.POP.TOTL"), geometry = "sf") |>
#   dorling_map(pop, k = 4)
# 
# # The fast flow-based cartogram (Gastner-Seguy-More): needs `cartogramR`
# world_data(2020, c(pop = "SP.POP.TOTL"), geometry = "sf") |>
#   cartogram_map(pop, type = "flow")
# 
# # Animated choropleth over a year panel: needs `gganimate`
# world_data(2000:2020, c(gdp = "NY.GDP.PCAP.KD")) |>
#   animate_world(gdp)
# 
# # Interactive choropleth: needs `leaflet`, `ggiraph` or `plotly`
# world_data(2020) |>
#   interactive_map(gdp_per_capita, engine = "plotly")

## ----eval = has_maps, fig.alt = "Value-by-alpha map of GDP per capita weighted by population."----
mapdf <- attach_geometry(snap, geometry = "polygon")
value_by_alpha_map(mapdf, gdp_per_capita, population)

## -----------------------------------------------------------------------------
distance_between("France", "Germany")

## ----eval = has_sf------------------------------------------------------------
neighbors("France")

