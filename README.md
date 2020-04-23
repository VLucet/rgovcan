# rgovcan <img src="inst/rgovcan_hex.png" align="right" width=140/>

## Easy access to the Canadian Open Government Portal

[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
[![Travis-CI Build
Status](https://travis-ci.org/VLucet/rgovcan.svg?branch=master)](https://travis-ci.org/vlucet/rgovcan)

A R package to interact with the Open Canada API, to search and download
datasets. It is our hope that we will be able to bring this package up
to the standard of a `ropensci` packages (see this issue on
`ropensci/wishlist` <https://github.com/ropensci/wishlist/issues/27>).

This package makes extensive use of `ckanr` to access the Canadian
government’s CKAN REST API.

The code is under GPL-3 license. All the data is under Open Government
License (<http://open.canada.ca/en/open-government-licence-canada>).

Hex Logo done with `hexSticker`:
<https://github.com/GuangchuangYu/hexSticker>

## Installation

Until release to CRAN, you will need to use `devtools` to install from
source.

``` r
devtools::install_github("vlucet/rgovcan")
```

## Usage

1.  First, load the package. The default `ckanr` url will be set to the
    Open Canada Portal.

<!-- end list -->

``` r
library("rgovcan")
```

    ## rgovcan package - alpha release - attached

    ## ckanr url set to https://open.canada.ca/data/en

If you happen to change the default url, you can reset it back to the
default with `govcan_setup`.

``` r
govcan_setup()
```

    ## ckanr url set to https://open.canada.ca/data/en

2.  A typical workflow with `rgovcan` can start with running
    `govcan_search` on a given set of keywords. This yields a `stack` of
    `ckan_packages` (object of class `ckan_package_stack`).

<!-- end list -->

``` r
dfo_search <- govcan_search(keywords = c("dfo"), records = 10)
```

    ## Searching the Open Portal for records matching: dfo

    ## CKAN query: 260 records found for keywords: dfo

    ## 260 matching records were found, 10 records were returned

``` r
dfo_search # outputs a `ckan_package_stack`
```

    ## <CKAN Package Stack with 10 Packages> 
    ##  
    ##   First 5 packages:  
    ##  
    ## <CKAN Package> 5cfd93bd-b3ee-4b0b-8816-33d388f6811d 
    ##   Title: DFO sea lice audits of BC marine finfish aquaculture sites
    ## <CKAN Package> 4dc95665-3d44-428c-bb26-12f981c57060 
    ##   Title: DFO’s fish health monitoring activities at BC aquaculture sites
    ## <CKAN Package> 6c891715-317c-4d4d-9fe8-ea425e01d9d2 
    ##   Title: Results of DFO fish health audits of British Columbian marine finfish aquaculture sites, by facility
    ## <CKAN Package> c1a54a0c-4eb0-4b50-be1f-01aee632527e 
    ##   Title: Results of DFO benthic audits of British Columbia marine finfish aquaculture sites
    ## <CKAN Package> f32ce23d-4a16-4eaa-9648-2f02a98b91af 
    ##   Title: Oceans Protection Plan Regional Response Planning Extents

see `?govcan_search` for further details.

3.  Another possibility is to start with a package id corresponding to
    an actual record and retrieve a `ckan_package`.

<!-- end list -->

``` r
id <- "7ac5fe02-308d-4fff-b805-80194f8ddeb4" # Package ID
id_search <- govcan_get_record(record_id = id)
```

    ## Searching for dataset with id: 7ac5fe02-308d-4fff-b805-80194f8ddeb4

    ## Record found: "Pacific Region Commercial Salmon Fishery In-season Catch Estimates"

``` r
id_search # outputs a `ckan_package`
```

    ## <CKAN Package> 7ac5fe02-308d-4fff-b805-80194f8ddeb4 
    ##   Title: Pacific Region Commercial Salmon Fishery In-season Catch Estimates
    ##   Creator/Modified: 2018-09-21T12:18:04.128562 / 2020-04-21T20:33:30.110523
    ##   Resources (up to 5): Data Dictionary, Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019, Data Dictionary, Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019, Pacific Region Commercial Salmon Fishery In-season Catch Estimates
    ##   Tags (up to 5): 
    ##   Groups (up to 5):

4.  Once the packages have been retrieved from the portal, you can use
    `govcan_get_resources` on those results to display the
    `ckan_resource`s contained in the packages (a “resource” is any
    dataset attached to a given record). This outputs a
    `ckan_resource_stack` when called on a unique package.

<!-- end list -->

``` r
id_resources <- govcan_get_resources(id_search)
id_resources # outputs a `resource_stack`
```

    ## <CKAN Resource Stack with 5 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> 593847c4-053d-420c-8429-650ced30e136 
    ##   Name: Data Dictionary
    ##   Format: HTML
    ## <CKAN Resource> 443c62bb-2a85-44fe-bea7-ebf49e65e3da 
    ##   Name: Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019
    ##   Format: CSV
    ## <CKAN Resource> 0186ca95-35fe-4f20-9751-3b92105bf550 
    ##   Name: Data Dictionary
    ##   Format: CSV
    ## <CKAN Resource> d94bc8f4-6cce-432f-a229-cd1cb749854d 
    ##   Name: Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019
    ##   Format: ESRI REST
    ## <CKAN Resource> a2f471ac-ee48-4da1-96c4-49973f9cfe67 
    ##   Name: Pacific Region Commercial Salmon Fishery In-season Catch Estimates
    ##   Format: ESRI REST

Or a list of stacks if called onto a `ckan_package_stack`.

``` r
dfo_resources <- govcan_get_resources(dfo_search)
dfo_resources # outputs a list of `resource_stack`s
```

    ## [[1]]
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
    ## [[2]]
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
    ## [[3]]
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
    ## [[4]]
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
    ## [[5]]
    ## <CKAN Resource Stack with 3 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> bb01c294-9f21-44ed-bd73-341f18d25419 
    ##   Name: Oceans Protection Plan Extent- Data Dictionary
    ##   Format: HTML
    ## <CKAN Resource> 28555692-fb08-40d4-865e-83dbe4bfd2e6 
    ##   Name: Oceans Protection Plan Regional Response Planning Extents
    ##   Format: ESRI REST
    ## <CKAN Resource> 26a19e90-f21a-44b5-9f49-405d9b751a33 
    ##   Name: Oceans Protection Plan Regional Response Planning Extents
    ##   Format: ESRI REST
    ## 
    ## [[6]]
    ## <CKAN Resource Stack with 3 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> baa41cff-9357-4d41-86f1-26cf4d330040 
    ##   Name: Federal Marine Bioregions
    ##   Format: FGDB/GDB
    ## <CKAN Resource> 68fdd715-7376-4ff5-a2a2-c758bb1936e1 
    ##   Name: Federal Marine Bioregions
    ##   Format: ESRI REST
    ## <CKAN Resource> 00f0c169-ed9f-4b3e-a20b-03fe465f3814 
    ##   Name: Federal Marine Bioregions
    ##   Format: ESRI REST
    ## 
    ## [[7]]
    ## <CKAN Resource Stack with 7 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> a5d3af15-dade-4aa6-a4c5-7396c1ac5915 
    ##   Name: Science Advisory Report 2016/039
    ##   Format: HTML
    ## <CKAN Resource> 3d2e4fee-4bfb-4ffe-970d-68e70a214fbb 
    ##   Name: Terms of Reference
    ##   Format: HTML
    ## <CKAN Resource> cbee4a17-8af0-4ab7-9ade-1676c0281b0e 
    ##   Name: Proceedings 2017/043
    ##   Format: HTML
    ## <CKAN Resource> 71c936bd-2519-4b3c-baf9-77ff0a4a60fa 
    ##   Name: Acoustic Doppler Current Profiler data from the Coast of Bays, Newfoundland
    ##   Format: ESRI REST
    ## <CKAN Resource> fcca9fe8-eccd-4e4b-81a9-6f81538bfe7c 
    ##   Name: Acoustic Doppler Current Profiler data from the Coast of Bays, Newfoundland
    ##   Format: ESRI REST
    ## <CKAN Resource> 9b7c9269-aa21-4d3d-9979-d3a840c24f60 
    ##   Name: ADCP Data
    ##   Format: ZIP
    ## <CKAN Resource> 7116b8ba-d6d8-4c7c-90f4-60389c7f9ad2 
    ##   Name: Coast of Bays ADCP stations 2009-2014
    ##   Format: CSV
    ## 
    ## [[8]]
    ## <CKAN Resource Stack with 2 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> 983a70a0-435a-4ba4-aaaf-6efa0def06ac 
    ##   Name: Mailing address and contact details for primary offices for Fisheries and Oceans Canada (English)
    ##   Format: ESRI REST
    ## <CKAN Resource> c8970b71-7f77-4c24-ab94-f90ec23af81d 
    ##   Name: Mailing address and contact details for primary offices for Fisheries and Oceans Canada (French)
    ##   Format: ESRI REST
    ## 
    ## [[9]]
    ## <CKAN Resource Stack with 4 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> 299b5db6-a4f8-4905-a16b-4a4b79887f90 
    ##   Name: Data Dictionary
    ##   Format: CSV
    ## <CKAN Resource> 6a344c5f-9919-4f70-9e1b-0a96767390c5 
    ##   Name: EBSA
    ##   Format: FGDB/GDB
    ## <CKAN Resource> 639615c4-b76d-41fa-93db-e4db72ca9f58 
    ##   Name: EBSA
    ##   Format: ESRI REST
    ## <CKAN Resource> f8dc3187-668e-4f4e-8ab6-5c260d204cbd 
    ##   Name: EBSA
    ##   Format: ESRI REST
    ## 
    ## [[10]]
    ## <CKAN Resource Stack with 6 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> 519d6e21-c5dd-430e-a1f9-4784e4eb8188 
    ##   Name: Data Dictionary
    ##   Format: CSV
    ## <CKAN Resource> 880b0ddc-1956-4e83-b96e-0042e6324921 
    ##   Name: NEEC Atlantic Cod Presence MAR ARP Pilots
    ##   Format: FGDB/GDB
    ## <CKAN Resource> 37070e15-4aeb-421a-9680-381defb03303 
    ##   Name: Atlantic Cod Presence MAR ARP Pilots
    ##   Format: FGDB/GDB
    ## <CKAN Resource> c3349b4f-3de2-429f-afdc-274cb2ff5554 
    ##   Name: NEEC Data Dictionary
    ##   Format: CSV
    ## <CKAN Resource> 2eb87ea9-4c12-46ab-8f8d-65462df9dc50 
    ##   Name: Atlantic Cod Presence MAR ARP Pilots
    ##   Format: ESRI REST
    ## <CKAN Resource> 5cf54524-80a6-48fd-aeb6-3822ad38fd7c 
    ##   Name: Atlantic Cod Presence MAR ARP Pilots
    ##   Format: ESRI REST

5.  Finally, you can download the resources with `govcan_dl_resources`.
    These can either be stored to a certain directory or load into
    session (\* this option might fail due to current issues with
    `ckanr::ckan_fetch`).

<!-- end list -->

``` r
path <- "tmp/data/"
dir.create(path, recursive = TRUE)
```

    ## Warning in dir.create(path, recursive = TRUE): 'tmp/data' already exists

``` r
govcan_dl_resources(id_resources, file_formats = c("JSON", "CSV", "SHP"), where = path)
```

    ##  ---------------------------------------------------------------- 
    ##  CSV file named Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2019 downloaded successfully 
    ##  path to file is: tmp/data/CommercialSalmonInSeasonCatchEstimatesInPiecesFrom2004To2019.CSV 
    ##  ---------------------------------------------------------------- 
    ##  ---------------------------------------------------------------- 
    ##  CSV file named Data Dictionary downloaded successfully 
    ##  path to file is: tmp/data/DataDictionary.CSV 
    ##  ----------------------------------------------------------------

``` r
# govcan_dl_resources(res_pel, file_formats = c("JSON", "CSV", "SHP"), where = "session")
```

see `?govcan_dl_resources` for further details.
