## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 4, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
has_sf <- requireNamespace("sf", quietly = TRUE) &&
  requireNamespace("rnaturalearth", quietly = TRUE) &&
  requireNamespace("rnaturalearthdata", quietly = TRUE)
has_globe <- requireNamespace("maps", quietly = TRUE) &&
  requireNamespace("mapproj", quietly = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# install.packages(c("sf", "rnaturalearth", "rnaturalearthdata"))

## ----eval = FALSE-------------------------------------------------------------
# world_data(2020, c(gdp = "NY.GDP.PCAP.KD"), geometry = "sf") |>
#   world_map(gdp, style = "quantile", projection = "equal_earth",
#             title = "GDP per capita (Equal Earth projection)")

## ----globe, eval = has_globe, fig.width = 5.5, fig.height = 5-----------------
# globe_map(world_snapshot$countries, continent, backend = "polygon",
#           style = "categorical", lon = 10, lat = 20)

## ----eval = FALSE-------------------------------------------------------------
# # With the sf backend (smoother limb, real great circles):
# world_data(2020, geometry = "sf") |>
#   globe_map(gdp_per_capita, lon = 10, lat = 30)

## ----eval = FALSE-------------------------------------------------------------
# spin_globe(world_snapshot$countries, continent, backend = "polygon",
#            style = "categorical", n_frames = 60)

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

## ----eval = has_sf------------------------------------------------------------
# med <- world_geometry("countries", geometry = "sf",
#                       region = c(-10, 30, 40, 48), projection = "equal_earth")
# ggplot(med) +
#   geom_sf(fill = "grey85", colour = "grey40", linewidth = 0.1) +
#   theme_world_map()

## ----eval = FALSE-------------------------------------------------------------
# world_geometry(geometry = "sf", scale = "medium") |>
#   simplify_geometry(keep = 0.1)

