## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = TRUE,
                      warning = TRUE)
library(countryatlas)

## -----------------------------------------------------------------------------
pan <- expand.grid(iso3c = c("GBR", "FRA", "VNM", "PAK", "AFG"),
                   year = 2019:2026, stringsAsFactors = FALSE)
pan$gdp <- round(1000 * (1 + 0.03)^(pan$year - 2019) *
                   c(GBR = 42, FRA = 39, VNM = 3.5, PAK = 1.5, AFG = 0.5)[pan$iso3c])
head(pan)

## -----------------------------------------------------------------------------
pop <- expand.grid(iso3c = c("United Kingdom", "France", "Viet Nam"),
                   year = 2019:2026, stringsAsFactors = FALSE)
pop$population <- 1e6 * c(67, 68, 98)[match(pop$iso3c, unique(pop$iso3c))]
joined <- country_join(pan, pop, iso3c, iso3c, origin_x = "iso3c")
nrow(joined) == nrow(pan)

## -----------------------------------------------------------------------------
uk <- pan[pan$iso3c == "GBR", ]
uk$eu <- in_group(uk$iso3c, "EU", origin = "iso3c", as_of = uk$year)
uk[, c("year", "eu")]

## -----------------------------------------------------------------------------
in_group(rep("SYR", 3), "ArabLeague", origin = "iso3c", as_of = c(2010, 2015, 2024))

## -----------------------------------------------------------------------------
classify_countries(pan[pan$iso3c == "VNM" & pan$year >= 2024, ], "income")

## -----------------------------------------------------------------------------
classify_countries(data.frame(iso3c = "VNM", year = 2025), "income",
                   basis = "data_year")

## -----------------------------------------------------------------------------
reg <- classify_countries(pan[pan$iso3c %in% c("PAK", "AFG") &
                                pan$year %in% c(2025, 2026), ], "region")
reg[, c("iso3c", "year", "region")]

## -----------------------------------------------------------------------------
gappy <- pan[pan$iso3c == "FRA" & pan$year != 2022, c("iso3c", "year", "gdp")]
growth_rate(gappy, gdp)[, c("year", "gdp_growth")]

## -----------------------------------------------------------------------------
aggregate_groups(world_snapshot$countries, gdp_per_capita,
                 groups = c("EU", "ASEAN", "SADC"), fun = "weighted_mean",
                 weight = population)

## -----------------------------------------------------------------------------
aggregate_groups(pan, gdp, groups = "EU", as_of = 2019)

