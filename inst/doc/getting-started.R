## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 4, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
library(dplyr)

# The polygon backend needs `maps`, which is only in Suggests, so every chunk
# that attaches or draws polygon geometry is guarded on this. Without it the
# vignette still builds -- it just skips the maps.
has_maps <- requireNamespace("maps", quietly = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# data_2020 <- world_data(2020)

## ----eval = has_maps----------------------------------------------------------
data_2020 <- attach_geometry(world_snapshot$countries, geometry = "polygon")

## ----eval = has_maps, fig.alt = "World choropleth of GDP per capita in quantile bins."----
world_map(data_2020, gdp_per_capita, style = "quantile",
          title = "GDP per capita")

## ----eval = has_maps, fig.alt = "World map coloured by World Bank income group."----
world_map(data_2020, income, style = "categorical")

## -----------------------------------------------------------------------------
head(common_indicators)

## -----------------------------------------------------------------------------
head(wdi_search("renewable energy"))

## ----eval = FALSE-------------------------------------------------------------
# country_data(2020, c(life_exp = "SP.DYN.LE00.IN", pop = "SP.POP.TOTL"))

