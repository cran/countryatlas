## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  warning = FALSE,
  fig.width = 7,
  fig.height = 4,
  fig.align = "center",
  dpi = 96
)
library(countryatlas)
library(ggplot2)
library(dplyr)

## -----------------------------------------------------------------------------
snapshot <- world_snapshot$countries
dplyr::glimpse(snapshot)

## ----eval = FALSE-------------------------------------------------------------
# # Live World Bank API call (not evaluated here to keep the vignette offline):
# world_data(2020)
# world_data(
#   2020,
#   indicator = c(life_exp = "SP.DYN.LE00.IN", co2 = "EN.GHG.CO2.PC.CE.AR5"),
#   geometry  = "sf",
#   region    = "Africa"
# )

## -----------------------------------------------------------------------------
mapdf <- attach_geometry(snapshot, geometry = "polygon")
dim(mapdf)

## -----------------------------------------------------------------------------
world_map(mapdf, gdp_per_capita, style = "quantile",
          title = "GDP per capita (quantile bins)")

## -----------------------------------------------------------------------------
world_map(mapdf, continent, style = "categorical")

## -----------------------------------------------------------------------------
bubble_map(snapshot, population)

## ----fig.height = 5-----------------------------------------------------------
tile_map(snapshot, life_expectancy)

## -----------------------------------------------------------------------------
flows <- data.frame(
  from   = c("China", "Germany", "Brazil", "India"),
  to     = c("United States", "France", "Japan", "United Kingdom"),
  weight = c(500, 200, 150, 120)
)
flow_map(flows, from, to, weight)

## -----------------------------------------------------------------------------
messy <- data.frame(
  nation = c("U.S.", "S. Korea", "Czechia", "Kosovo", "Cote d'Ivoire"),
  value  = c(10, 8, 6, 4, 7)
)
standardize_country(messy, nation, warn = FALSE)

## -----------------------------------------------------------------------------
left  <- data.frame(country = c("Czechia", "South Korea"), gdp = c(1, 2))
right <- data.frame(nation  = c("Czech Republic", "Korea, Rep."), pop = c(10, 51))
country_join(left, right, country, nation)

## -----------------------------------------------------------------------------
check_country_match(c("USA", "Cote d'Ivoire", "Yugoslavia", "Wakanda"))

## -----------------------------------------------------------------------------
audit_coverage(snapshot)$na_rates

## -----------------------------------------------------------------------------
dropped <- c("Kosovo", "Micronesia", "Virgin Islands", "Canary Islands",
             "Saint Martin")
standardize_country(data.frame(region = dropped), region, warn = FALSE)

## -----------------------------------------------------------------------------
convert_country(c("Japan", "Brazil", "Germany"), to = "flag")
convert_country(c("Japan", "Brazil", "Germany"), to = "currency")

## -----------------------------------------------------------------------------
country_groups("G7")
in_group(c("France", "United States", "Japan", "Brazil"), "EU")

## -----------------------------------------------------------------------------
snapshot |>
  rank_countries(gdp_per_capita) |>
  filter(rank <= 5) |>
  select(country, gdp_per_capita, rank, percentile)

## -----------------------------------------------------------------------------
snapshot |>
  aggregate_regions(population, by = "region", fun = "sum")

## -----------------------------------------------------------------------------
sessionInfo()

