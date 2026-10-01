## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 3.6, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
snap <- world_snapshot$countries
has_maps <- requireNamespace("maps", quietly = TRUE)
has_sf <- requireNamespace("sf", quietly = TRUE) &&
  requireNamespace("rnaturalearth", quietly = TRUE) &&
  requireNamespace("rnaturalearthdata", quietly = TRUE)

## ----setup-data, eval = has_maps----------------------------------------------
mapdf <- attach_geometry(snap, geometry = "polygon")

## ----classify, eval = has_maps, fig.height = 3.2, fig.alt = "GDP per capita under quantile, Jenks, equal-interval and pretty breaks."----
cmp <- classify_compare(mapdf, gdp_per_capita, ncol = 2)
cmp

## ----classify-report, eval = has_maps-----------------------------------------
attr(cmp, "countryatlas_classification")

## ----one-report, eval = has_maps----------------------------------------------
p <- world_map(mapdf, gdp_per_capita, style = "quantile",
               classification_report = TRUE)
attr(p, "countryatlas_classification")

## ----na-style, eval = has_maps, fig.alt = "World choropleth with missing countries drawn in diagonal hatching."----
world_map(mapdf, co2_per_capita, style = "quantile",
          na_style = "hatched", footnote = "auto")

## ----coverage, eval = has_maps, fig.alt = "Map of which countries report CO2 per capita."----
coverage_map(mapdf, co2_per_capita)

## ----vba, eval = has_maps, fig.alt = "Value-by-alpha map: GDP per capita in colour, population as opacity, over a dark background."----
value_by_alpha_map(mapdf, gdp_per_capita, population)

## ----proj-info----------------------------------------------------------------
projection_info()[, c("projection", "property", "equal_area", "conformal")]

## ----equal-area---------------------------------------------------------------
subset(projection_info(), equal_area)$projection

## ----tissot-merc, eval = has_sf, fig.height = 4, fig.alt = "Tissot indicatrices on Mercator: circles stay circular but grow enormously toward the poles."----
tissot_map("mercator")

## ----tissot-ee, eval = has_sf, fig.alt = "Tissot indicatrices on Equal Earth: ellipses shear but hold constant area."----
tissot_map("equal_earth")

## ----proj-compare, eval = has_sf, fig.height = 4.2, fig.alt = "One choropleth drawn under four projections."----
attach_geometry(snap, geometry = "sf") |>
  projection_compare(gdp_per_capita, style = "quantile", labeller = "property")

## ----provenance, eval = has_maps, message = TRUE------------------------------
world_map(mapdf, gdp_per_capita, style = "quantile", n_bins = 5,
          na_style = "hatched", footnote = "auto") |>
  map_provenance()

## ----hist, eval = requireNamespace("cshapes", quietly = TRUE) && has_sf, fig.alt = "Choropleth drawn on 1950 borders including colonies and dependencies."----
attach_geometry(snap[, c("iso3c", "gdp_per_capita")], year = 1950) |>
  world_map(gdp_per_capita, style = "quantile",
            title = "1950 borders, 1950 world")

## ----asof---------------------------------------------------------------------
c(`2016` = in_group("United Kingdom", "EU", as_of = 2016),
  `2021` = in_group("United Kingdom", "EU", as_of = 2021))

## ----weights, eval = has_sf---------------------------------------------------
rbind(
  contiguity = morans_i(snap, gdp_per_capita, n_perm = 0)[c("i", "n", "n_excluded")],
  knn = morans_i(snap, gdp_per_capita, n_perm = 0,
                 weights = country_weights("knn", k = 5))[c("i", "n", "n_excluded")]
)

