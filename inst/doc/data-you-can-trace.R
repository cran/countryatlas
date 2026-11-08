## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = TRUE,
                      warning = TRUE, fig.width = 7, fig.height = 3.4,
                      dpi = 96)
library(countryatlas)

## -----------------------------------------------------------------------------
snap <- world_snapshot$countries
source_info(snap)[, c("column", "indicator", "unit", "vintage", "licence")]

## ----map, fig.alt = "World map of GDP per capita, with a caption naming the coverage and the World Bank release."----
p <- world_map(attach_geometry(snap), gdp_per_capita)
p

## -----------------------------------------------------------------------------
map_provenance(p)
map_citation(p)[1:2]

## ----eval = FALSE-------------------------------------------------------------
# d <- world_data(2020, c(life_exp = "SP.DYN.LE00.IN"))   # World Bank
# o <- fetch_indicator("owid", "life-expectancy")         # Our World in Data
# w <- fetch_sdmx("imf", "WEO", key = "NGDP_RPCH")        # any SDMX provider
# source_info(d)

## ----eval = FALSE-------------------------------------------------------------
# wdi_vintages()                                       # the releases on record
# world_data(2015, vintage = "2024-07")                # this release, every time
# compare_vintages("NY.GDP.PCAP.KD", c("2023-07", "2024-07"), year = 2015)

## -----------------------------------------------------------------------------
survey <- function(indicator, countries = NULL, years = NULL) {
  out <- data.frame(iso3c = c("FRA", "DEU", "JPN"), year = 2020L,
                    lfp = c(61.2, 62.8, 62.0))
  source_info(out) <- data.frame(column = "lfp", source = "survey",
                                 unit = "percent", vintage = "2021 wave")
  out
}
register_country_source("survey", survey, meta = "A labour-force survey")
lfp <- fetch_indicator("survey", "lfp")
source_info(lfp)[, c("column", "source", "unit", "vintage")]

## -----------------------------------------------------------------------------
shares <- function(indicator, countries = NULL, years = NULL) {
  out <- data.frame(iso3c = c("FRA", "DEU", "JPN"), year = 2020L,
                    lfp = c(0.611, 0.629, 0.618))
  source_info(out) <- data.frame(column = "lfp", source = "shares",
                                 unit = "share")
  out
}
register_country_source("shares", shares)
try(compare_sources("lfp", sources = c("survey", "shares"), year = 2020))

## ----include = FALSE----------------------------------------------------------
remove_country_source(c("survey", "shares"))

