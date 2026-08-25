## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE
)
library(countryatlas)

## -----------------------------------------------------------------------------
world_query(
  gdp_per_capita,
  projection = "equal_earth",
  palette    = "magma",
  transform  = "log10",
  title      = "GDP per capita"
)

## ----eval = FALSE-------------------------------------------------------------
# # needs: ggsql, duckdb, DBI, sf
# world_data(2020, geometry = "sf") |>
#   interactive_map(gdp_per_capita, engine = "ggsql", transform = "log10")

## ----eval = FALSE-------------------------------------------------------------
# src <- world_data(2020, geometry = "sf") |>
#   as_ggsql_source(format = "duckdb")          # a DuckDB connection
# 
# q <- world_query(gdp_per_capita, projection = "orthographic", palette = "viridis")
# 
# ggsql::ggsql_execute(src, q)                  # -> Vega-Lite widget

