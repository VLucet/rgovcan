
# rgovcan <img src="man/figures/logo.png" align="right" width=140/>

## Easy Access to the Canadian Open Government Portal

[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
[![R-CMD-check](https://github.com/VLucet/rgovcan/workflows/R-CMD-check/badge.svg)](https://github.com/VLucet/rgovcan/actions)
[![Codecov test
coverage](https://codecov.io/gh/VLucet/rgovcan/branch/master/graph/badge.svg)](https://codecov.io/gh/VLucet/rgovcan?branch=master)
[![CRAN
Version](https://img.shields.io/cran/v/rgovcan?label=CRAN)](https://CRAN.R-project.org/package=rgovcan)
[![Downloads](https://cranlogs.r-pkg.org/badges/rgovcan?color=blue)](https://CRAN.R-project.org/package=rgovcan/)

A R package to interact with the Open Canada API (see
<https://open.canada.ca/en/access-our-application-programming-interface-api>),
to search and download datasets (see Licence at
<https://open.canada.ca/en/open-government-licence-canada>). It is our
hope that we will be able to bring this package up to the standard of a
`ropensci` packages (see this issue on `ropensci/wishlist`
<https://github.com/ropensci/wishlist/issues/27>).

This package makes extensive use of `ckanr` to access the Canadian
government’s CKAN REST API.

The code is under GPL-3 license. All the data is under Open Government
License (<http://open.canada.ca/en/open-government-licence-canada>).

Hex Logo done with `hexSticker`:
<https://github.com/GuangchuangYu/hexSticker>

## Installation

You can install `rgovcan` from CRAN like so:

``` r
install.packages("rgovcan")
```

For the development version, you will need to use
[`remotes`](https://CRAN.R-project.org/package=remotes) to install from
source:

``` r
install.packages("remotes")
remotes::install_github("vlucet/rgovcan")
```

## Usage

1.  First, load the package. The default
    [`ckanr`](https://CRAN.R-project.org/package=ckanr) url will be set
    to the Open Canada Portal.

``` r
library("rgovcan")
```

    ## ℹ ckanr url set to https://open.canada.ca

If you happen to change the default url, you can reset it back to the
default with `govcan_setup()`.

``` r
govcan_setup()
```

    ## ℹ ckanr url set to https://open.canada.ca

2.  A typical workflow with `rgovcan` can start with running
    `govcan_search()` on a given set of keywords. This yields a `stack`
    of `ckan_packages()` (object of class `ckan_package_stack`).

``` r
dfo_search <- govcan_search(keywords = c("dfo"), records = 10)
```

    ## ℹ Searching the Open Portal for records matching: dfo

    ## ℹ CKAN query: 437 records found for keywords: dfo

    ## ℹ 437 matching records were found, 10 records were returned

``` r
dfo_search # outputs a `ckan_package_stack`
```

    ## ── <CKAN Package Stack with 10 Packages> ───────────────────────────────────────
    ## 
    ##   First 5 packages:  
    ## 
    ## → <CKAN Package> 5798c4b6-d9d6-4328-9349-f66020403b4c
    ##   Title: Ministerial transition binder 2018 (DFO)
    ## → <CKAN Package> 830908ab-6abd-461d-ace9-b2673dd92b30
    ##   Title: Ministerial transition binder 2019 (DFO)
    ## → <CKAN Package> 5cfd93bd-b3ee-4b0b-8816-33d388f6811d
    ##   Title: DFO sea lice audits of BC marine finfish aquaculture sites
    ## → <CKAN Package> 4dc95665-3d44-428c-bb26-12f981c57060
    ##   Title: DFO’s fish health monitoring activities at BC aquaculture sites
    ## → <CKAN Package> c1a54a0c-4eb0-4b50-be1f-01aee632527e
    ##   Title: Results of DFO benthic audits of British Columbia marine finfish aquaculture sites

see `?govcan_search` for further details.

3.  Another possibility is to start with a package id corresponding to
    an actual record and retrieve a `ckan_package`.

``` r
id <- "7ac5fe02-308d-4fff-b805-80194f8ddeb4" # Package ID
id_search <- govcan_get_record(record_id = id)
```

    ## ℹ Searching for dataset with id:  7ac5fe02-308d-4fff-b805-80194f8ddeb4

    ## ℹ Record found: "Pacific Region Commercial Salmon Fishery In-season Catch Estimates"

``` r
id_search # outputs a `ckan_package`
```

    ## <CKAN Package> 7ac5fe02-308d-4fff-b805-80194f8ddeb4 
    ##   Title: Pacific Region Commercial Salmon Fishery In-season Catch Estimates
    ##   Creator/Modified: 2018-09-21T12:18:04.128562 / 2020-04-30T17:49:14.169519
    ##   Resources (up to 5): Data Dictionary, Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019, Data Dictionary, Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019, Pacific Region Commercial Salmon Fishery In-season Catch Estimates
    ##   Tags (up to 5): 
    ##   Groups (up to 5):

4.  Once the packages have been retrieved from the portal, you can use
    `govcan_get_resources` on those results to display the
    `ckan_resource`s contained in the packages (a “resource” is any
    dataset attached to a given record). This outputs a
    `ckan_resource_stack` when called on a unique package.

``` r
id_resources <- govcan_get_resources(id_search)
id_resources # outputs a `resource_stack`
```

    ## <CKAN Resource Stack with 5 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> 0c1b2697-4ba6-4b66-b70f-72445d00443b 
    ##   Name: Data Dictionary
    ##   Format: HTML
    ## <CKAN Resource> eb138d6a-1a8b-4907-af91-c9c728fe9531 
    ##   Name: Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019
    ##   Format: CSV
    ## <CKAN Resource> f3e7fa0f-65d5-408d-919c-0e31a26251f2 
    ##   Name: Data Dictionary
    ##   Format: CSV
    ## <CKAN Resource> 9374bf48-9f71-4216-9b2a-ddf295b30046 
    ##   Name: Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019
    ##   Format: ESRI REST
    ## <CKAN Resource> 53b268cb-d734-4432-8798-aa9f6ddbd637 
    ##   Name: Pacific Region Commercial Salmon Fishery In-season Catch Estimates
    ##   Format: ESRI REST

Or a list of stacks if called onto a `ckan_package_stack`.

``` r
dfo_resources <- govcan_get_resources(dfo_search)
dfo_resources # outputs a list of `resource_stack`s
```

    ## [[1]]
    ## <CKAN Resource Stack with 2 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> 588f9a30-a588-4b6a-bebd-ef82e1b67680 
    ##   Name: Ministerial transition binder 2018
    ##   Format: HTML
    ## <CKAN Resource> 8acdcfe5-6434-4d11-82e8-70def931c26e 
    ##   Name: Ministerial transition binder 2018
    ##   Format: HTML
    ## 
    ## [[2]]
    ## <CKAN Resource Stack with 2 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> 6c13c5e1-78c9-40db-a729-93d9bd52d037 
    ##   Name: Ministerial transition binder 2019
    ##   Format: HTML
    ## <CKAN Resource> 427e7a83-be9f-4a4e-9777-31ad088252bb 
    ##   Name: Ministerial transition binder 2019
    ##   Format: HTML
    ## 
    ## [[3]]
    ## <CKAN Resource Stack with 6 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> 96852f26-a35d-4c4a-abe0-20a77aee8c93 
    ##   Name: DFO sea lice audits of BC marine finfish aquaculture sites, 2011 ongoing
    ##   Format: CSV
    ## <CKAN Resource> bc58d577-d47c-4df7-9627-b35a892368fa 
    ##   Name: DFO sea lice audits of BC marine finfish aquaculture sites, 2011 ongoing
    ##   Format: CSV
    ## <CKAN Resource> 001e49c7-0a70-4087-bb78-6094c445667e 
    ##   Name: DFO sea lice audits of BC marine finfish aquaculture sites
    ##   Format: CSV
    ## <CKAN Resource> 17d5ab8c-2b68-413a-8a11-734a1b8e8cf1 
    ##   Name: DFO sea lice audits of BC marine finfish aquaculture sites
    ##   Format: CSV
    ## <CKAN Resource> bdcdd26f-5e7e-4cc3-b6d8-77d36e9401e4 
    ##   Name: Create a Google Map using latitude and longitude data
    ##   Format: TXT
    ## <CKAN Resource> b1cc58cf-8edf-4264-9078-470d69c446d5 
    ##   Name: Create a Google Map using latitude and longitude data
    ##   Format: TXT
    ## 
    ## [[4]]
    ## <CKAN Resource Stack with 4 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> 26c2c849-b033-4092-8993-e1f50514d096 
    ##   Name: DFO’s fish health monitoring activities at BC aquaculture sites, 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> ed82597d-a30c-4f55-a4e2-71d7ac8b7fff 
    ##   Name: DFO’s fish health monitoring activities at BC aquaculture sites, 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> 2bd87c89-a755-4885-b6c5-d14beddc952b 
    ##   Name: DFO’s fish health monitoring activities at BC aquaculture sites
    ##   Format: CSV
    ## <CKAN Resource> cb52f0bf-dae7-4a97-baef-a45bb40dfa73 
    ##   Name: DFO’s fish health monitoring activities at BC aquaculture sites
    ##   Format: CSV
    ## 
    ## [[5]]
    ## <CKAN Resource Stack with 6 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> f51236a0-4ccc-4fd1-9fd0-f4a109065732 
    ##   Name: Results of DFO benthic monitoring audits of BC marine finfish aquaculture sites, 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> 220ce25f-534d-46ca-955f-41c8e8046be9 
    ##   Name: Results of DFO benthic monitoring audits of BC marine finfish aquaculture sites, 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> 010b3ad4-21b0-49b5-9269-0946f832818c 
    ##   Name: Results of DFO benthic monitoring audits of BC marine finfish aquaculture sites, 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> 57de280e-2516-4309-bac4-170d73f893a5 
    ##   Name: Results of DFO benthic monitoring audits of BC marine finfish aquaculture sites, 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> 8d4eeaee-ead7-432f-a109-10873f8f208d 
    ##   Name: Create a Google Map using latitude and longitude data 
    ##   Format: TXT
    ## <CKAN Resource> 18cb5078-7add-41f2-98e9-8b8ea2e01ce2 
    ##   Name: Create a Google Map using latitude and longitude data 
    ##   Format: TXT
    ## 
    ## [[6]]
    ## <CKAN Resource Stack with 2 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> ce3527ab-d761-40db-8903-9c5c2eaaa3ab 
    ##   Name: House of Commons committee of the whole on 2020-21 Main Estimates – DFO
    ##   Format: HTML
    ## <CKAN Resource> 7c013997-618c-45c0-a274-097bcb721901 
    ##   Name: House of Commons committee of the whole on 2020-21 Main Estimates – DFO
    ##   Format: HTML
    ## 
    ## [[7]]
    ## <CKAN Resource Stack with 6 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> b49ab71b-ec00-4e85-813b-d508c32166db 
    ##   Name: Results of DFO fish health audits of BC marine finfish aquaculture sites, by facility 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> 8681da09-ba23-40aa-a928-5fda929712fd 
    ##   Name: Results of DFO fish health audits of BC marine finfish aquaculture sites, by facility 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> 7bd96bb4-1608-4bea-b432-329d5ef469ec 
    ##   Name: Results of DFO fish health audits of BC marine finfish aquaculture sites, by facility 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> bb164f09-f6af-4bb2-bcf8-f2c34e9c8313 
    ##   Name: Results of DFO fish health audits of BC marine finfish aquaculture sites, by facility 2011 and ongoing
    ##   Format: CSV
    ## <CKAN Resource> 95b916b1-25a9-480d-9388-97ab68abec8b 
    ##   Name: Create a Google Map using latitude and longitude data
    ##   Format: TXT
    ## <CKAN Resource> a1b27546-5b73-419f-a8cd-6e5c35184413 
    ##   Name: Create a Google Map using latitude and longitude data
    ##   Format: TXT
    ## 
    ## [[8]]
    ## <CKAN Resource Stack with 2 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> 29f7b107-3d62-4f1e-a037-cb17e1162110 
    ##   Name: Mailing address and contact details for primary offices for Fisheries and Oceans Canada (English)
    ##   Format: ESRI REST
    ## <CKAN Resource> 0637be9d-e93c-4512-9c34-2e8d78094b7e 
    ##   Name: Mailing address and contact details for primary offices for Fisheries and Oceans Canada (French)
    ##   Format: ESRI REST
    ## 
    ## [[9]]
    ## <CKAN Resource Stack with 3 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> 0e8ed3c8-d67a-43e8-a4ea-1943b8762c53 
    ##   Name: Oceans Protection Plan Extent- Data Dictionary
    ##   Format: CSV
    ## <CKAN Resource> f3fce10e-157a-4638-9934-67a378710955 
    ##   Name: Oceans Protection Plan Regional Response Planning Extents
    ##   Format: ESRI REST
    ## <CKAN Resource> 428186d1-3603-4fd7-ad9d-b5ce7c6c5a3b 
    ##   Name: Oceans Protection Plan Regional Response Planning Extents
    ##   Format: ESRI REST
    ## 
    ## [[10]]
    ## <CKAN Resource Stack with 4 Resource> 
    ## 
    ##   Resources:  
    ## 
    ## <CKAN Resource> 1ad4cc94-25fa-4a77-8820-4f90a1826569 
    ##   Name: MSDI Dynamic Current Layer
    ##   Format: CSV
    ## <CKAN Resource> 6810bde3-74a3-44d7-92bd-1c7435e0e04f 
    ##   Name: MSDI Dynamic Current Layer
    ##   Format: ESRI REST
    ## <CKAN Resource> e0446817-be17-4bc2-abc9-304f9cc8e4d7 
    ##   Name: MSDI Dynamic Current Layer
    ##   Format: HTML
    ## <CKAN Resource> 3c601e26-562f-4a80-8cb4-43d24e76f01e 
    ##   Name: MSDI Dynamic Current Layer
    ##   Format: HTML

5.  Finally, you can download the resources with
    `govcan_dl_resources()`. These can either be stored to a certain
    directory or load into session (\* this option might fail due to
    current issues with `ckanr::ckan_fetch`).

``` r
path <- "tmp/data/"
dir.create(path, recursive = TRUE)
```

    ## Warning in dir.create(path, recursive = TRUE): 'tmp/data' already exists

``` r
govcan_dl_resources(id_resources, path = path)
```

    ## ℹ Data Dictionary (format: html - size: 63.4 Kb) ! skipped (already downloaded).
    ## ℹ Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019 (format: csv - size: 41.4 Kb) ! skipped (already downloaded).
    ## ℹ Data Dictionary (format: csv - size: 1.6 Kb) ! skipped (already downloaded).
    ## ℹ Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019 (format: esri rest - size: 0 bytes) ! skipped (not supported).
    ## ℹ Pacific Region Commercial Salmon Fishery In-season Catch Estimates (format: esri rest - size: 0 bytes) ! skipped (not supported).

    ## # A tibble: 5 x 7
    ##   id         package_id      url              path             fmt   store data 
    ##   <chr>      <chr>           <chr>            <chr>            <chr> <chr> <lgl>
    ## 1 0c1b2697-… 7ac5fe02-308d-… https://pacgis0… /home/vlucet/Do… html  disk  NA   
    ## 2 eb138d6a-… 7ac5fe02-308d-… https://pacgis0… /home/vlucet/Do… csv   disk  NA   
    ## 3 f3e7fa0f-… 7ac5fe02-308d-… https://pacgis0… /home/vlucet/Do… csv   disk  NA   
    ## 4 9374bf48-… 7ac5fe02-308d-… https://gisp.df… <NA>             esri… <NA>  NA   
    ## 5 53b268cb-… 7ac5fe02-308d-… https://gisp.df… <NA>             esri… <NA>  NA

see `?govcan_dl_resources` for further details.
