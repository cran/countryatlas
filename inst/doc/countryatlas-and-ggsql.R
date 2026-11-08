## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, comment = "#>", message = FALSE, warning = FALSE
)
library(countryatlas)
# Rendering in the database needs ggsql >= 0.5.0, sf, and a network connection
# the first time in a session, for DuckDB's spatial extension. So the chunks
# that render run when the website is built, and are shown as code elsewhere,
# including on CRAN.
render <- identical(Sys.getenv("IN_PKGDOWN"), "true") &&
  requireNamespace("ggsql", quietly = TRUE) &&
  utils::packageVersion("ggsql") >= "0.5.0" &&
  requireNamespace("sf", quietly = TRUE) &&
  requireNamespace("rnaturalearth", quietly = TRUE)
# And only when DuckDB's spatial extension can actually be fetched.
if (render) {
  render <- tryCatch({
    as_ggsql_source(attach_geometry(world_snapshot$countries[1, ],
                                    geometry = "sf"))
    TRUE
  }, warning = function(w) FALSE)
}

## -----------------------------------------------------------------------------
world_query(
  gdp_per_capita,
  projection = "equal_earth",
  palette    = "magma",
  transform  = "log10",
  title      = "GDP per capita"
)

## -----------------------------------------------------------------------------
world_query(gdp_per_capita, projection = "north_polar", layer = "binned")
world_query(gdp_per_capita, layer = "bubble", size = "population")

## ----eval = render------------------------------------------------------------
# d <- attach_geometry(world_snapshot$countries, geometry = "sf")
# interactive_map(d, gdp_per_capita, engine = "ggsql", transform = "log10")

## ----eval = render------------------------------------------------------------
# reader <- as_ggsql_source(d)
# spec <- ggsql::ggsql_execute(
#   reader,
#   world_query(gdp_per_capita, projection = "orthographic", palette = "viridis")
# )
# ggsql::ggsql_widget(spec)

