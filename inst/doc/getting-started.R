## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE,
  fig.width = 7, fig.height = 4, fig.align = "center", dpi = 96
)
library(countryatlas)
library(ggplot2)
library(dplyr)

## ----eval = FALSE-------------------------------------------------------------
# data_2020 <- world_data(2020)

## -----------------------------------------------------------------------------
data_2020 <- attach_geometry(world_snapshot$countries, geometry = "polygon")

## -----------------------------------------------------------------------------
world_map(data_2020, gdp_per_capita, style = "quantile",
          title = "GDP per capita")

## -----------------------------------------------------------------------------
world_map(data_2020, income, style = "categorical")

## -----------------------------------------------------------------------------
head(common_indicators)

## -----------------------------------------------------------------------------
head(wdi_search("renewable energy"))

## ----eval = FALSE-------------------------------------------------------------
# country_data(2020, c(life_exp = "SP.DYN.LE00.IN", pop = "SP.POP.TOTL"))

