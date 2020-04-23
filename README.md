
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

This package will make extensive use of `ckanr` to access the canadian
government’s CKAN REST API.

The code is under GPL-3 license. All the data is under Open Government
License (<http://open.canada.ca/en/open-government-licence-canada>).

Hex Logo done with `hexSticker`:
<https://github.com/GuangchuangYu/hexSticker>

## Installation

Untill release to CRAN, you will need to use `devtools` to install from
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
    `govcan_search` on a given set of keywords. This yiels a `stack` of
    `ckan_packages` (object of class `ckan_package_stack`).

<!-- end list -->

``` r
?govcan_search
dfo_search <- govcan_search(keywords = c("dfo"), records = 10)
```

    ## Searching the Open Portal for records matching: dfo

    ## CKAN query: 202 records found for keywords: dfo

    ## 202 matching records were found, 10 records were returned

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
    ## <CKAN Package> 29dd835b-7c96-4c62-b558-275dfe13cbe9 
    ##   Title: Bottlenose Whale Presence, Maritimes Region

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
    ##   Creator/Modified: 2018-09-21T12:18:04.128562 / 2019-02-25T14:40:37.117485
    ##   Resources (up to 5): Data Dictionary, Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2017, Pacific Fishery Management Areas - Feature Layer - Default, Commercial Salmon In-Season Catch Estimates, Commercial Salmon In-Season Catch Estimates
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

    ## <CKAN Resource Stack with 11 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> 9471e6e9-0f1d-40d4-b126-8656472690b1 
    ##   Name: Data Dictionary
    ##   Format: HTML
    ## <CKAN Resource> b402379e-e1d2-4f96-950b-02750dbbcaee 
    ##   Name: Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2017
    ##   Format: CSV
    ## <CKAN Resource> 969ae32a-be77-44aa-be46-d09dbdfa893a 
    ##   Name: Pacific Fishery Management Areas - Feature Layer - Default
    ##   Format: ESRI REST
    ## <CKAN Resource> 4aea1ea1-6f61-4e89-bff4-8e87d1101c82 
    ##   Name: Commercial Salmon In-Season Catch Estimates
    ##   Format: ESRI REST
    ## <CKAN Resource> 22c505bf-7c8a-4950-9071-e3993b299ce1 
    ##   Name: Commercial Salmon In-Season Catch Estimates
    ##   Format: ESRI REST
    ## <CKAN Resource> 50232624-ab23-4acf-b56a-fea83da4d3ae 
    ##   Name: Pacific Fishery Management Areas - Feature Layer - Default
    ##   Format: ESRI REST
    ## <CKAN Resource> 2978a458-f47c-4e53-92da-dc109943f56c 
    ##   Name: Pacific Fishery Management Areas - Dynamic Layer - PFMA Labels
    ##   Format: ESRI REST
    ## <CKAN Resource> 8bf8f43c-985f-4907-a251-0fa863599d64 
    ##   Name: Pacific Fishery Management Areas - Dynamic Layer - PFMA Labels
    ##   Format: ESRI REST
    ## <CKAN Resource> be7b32cb-ed75-4d18-93f4-4ea94cfe26ac 
    ##   Name: How to build a multilayered map
    ##   Format: HTML
    ## <CKAN Resource> 1f92c842-9e66-49d9-a040-69e25f9a4be9 
    ##   Name: How to build a multilayered map
    ##   Format: HTML
    ## <CKAN Resource> e40fe2fd-4fea-4c7e-8194-a65697a9c868 
    ##   Name: Data Dictionary
    ##   Format: CSV

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
    ##   Name: DFO’s fish health monitoring activities at BC aquaculture sites, 2011- 2018
    ##   Format: CSV
    ## <CKAN Resource> ed82597d-a30c-4f55-a4e2-71d7ac8b7fff 
    ##   Name: DFO’s fish health monitoring activities at BC aquaculture sites, 2011-2018
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
    ##   Name: Results of DFO benthic monitoring audits of BC marine finfish aquaculture sites, 2011 to 2017
    ##   Format: CSV
    ## <CKAN Resource> 220ce25f-534d-46ca-955f-41c8e8046be9 
    ##   Name: Results of DFO benthic monitoring audits of BC marine finfish aquaculture sites, 2011 to 2017
    ##   Format: CSV
    ## <CKAN Resource> 010b3ad4-21b0-49b5-9269-0946f832818c 
    ##   Name: Results of DFO benthic monitoring audits of BC marine finfish aquaculture sites, 2011 to 2017
    ##   Format: CSV
    ## <CKAN Resource> 57de280e-2516-4309-bac4-170d73f893a5 
    ##   Name: Results of DFO benthic monitoring audits of BC marine finfish aquaculture sites, 2011 to 2017
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
    ## <CKAN Resource> d3138042-61c8-4c6f-9ae4-c090245eb428 
    ##   Name: Ocean Protection Plan Data Dictionary En/Fr
    ##   Format: CSV
    ## <CKAN Resource> 1d435f19-6e8a-4afd-8a1d-e05394cc43af 
    ##   Name: Biota002_MarineMammals_NorthernBottlenoseWhale_PH_SJ_Presence
    ##   Format: ESRI REST
    ## <CKAN Resource> 3d62646b-bd0e-4327-b894-2882307c2a79 
    ##   Name: Biota002_MarineMammals_NorthernBottlenoseWhale_PH_SJ_Presence
    ##   Format: ESRI REST
    ## 
    ## [[6]]
    ## <CKAN Resource Stack with 3 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> c4ef0f94-5017-4a8a-9c6e-634d660c5dbc 
    ##   Name: Oceans Protection Plan Data Dictionary En FR
    ##   Format: CSV
    ## <CKAN Resource> 23083bf9-f13d-494b-beaf-5d31cacfb0b5 
    ##   Name: Biota002_MarineMammals_FinbackWhale_PH_SJ_Presence_En
    ##   Format: ESRI REST
    ## <CKAN Resource> 9e1ee5ba-e116-4fc6-be76-7f2e512d0bcb 
    ##   Name: Biota002_MarineMammals_FinbackWhale_PH_SJ_Presence_Fr
    ##   Format: ESRI REST
    ## 
    ## [[7]]
    ## <CKAN Resource Stack with 3 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> 049a6c69-d798-44d9-ba45-c14a9ee26262 
    ##   Name: Oceans Protection Plan data dictionary EnFr
    ##   Format: CSV
    ## <CKAN Resource> 6692fb52-6ba8-4ee6-a852-f28cdadc050a 
    ##   Name: Biota002_MarineMammals_NorthAtlanticRightWhale_PH_SJ_Presence
    ##   Format: ESRI REST
    ## <CKAN Resource> 80d31c7d-1c5b-4c9b-a7c2-d7fbfc77c00e 
    ##   Name: Biota002_MarineMammals_NorthAtlanticRightWhale_PH_SJ_Presence_Fr
    ##   Format: ESRI REST
    ## 
    ## [[8]]
    ## <CKAN Resource Stack with 3 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> 82da2921-9531-40d4-b2ea-0dd5f28e5bd9 
    ##   Name: Oceans Protection Plan Data Dictionary EnFr
    ##   Format: CSV
    ## <CKAN Resource> 50452236-ab3a-4578-8cf6-ec6b6e9e896f 
    ##   Name: Biota002_MarineMammals_HarbourPorpoise_PH_SJ_Presence
    ##   Format: ESRI REST
    ## <CKAN Resource> 2fb77235-5433-45a4-96f2-acd88d6d7d77 
    ##   Name: Biota002_MarineMammals_HarbourPorpoise_PH_SJ_Presence_Fr
    ##   Format: ESRI REST
    ## 
    ## [[9]]
    ## <CKAN Resource Stack with 3 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> 525432eb-f675-47fc-8828-466276f50e76 
    ##   Name: Oceans Protection Plan Extent- Data Dictionary
    ##   Format: HTML
    ## <CKAN Resource> 906e284a-3960-4dd3-bccc-4cf502dcda0e 
    ##   Name: Layers
    ##   Format: ESRI REST
    ## <CKAN Resource> 419b181b-1ea3-4689-99d9-daa7a82e8723 
    ##   Name: Layers
    ##   Format: ESRI REST
    ## 
    ## [[10]]
    ## <CKAN Resource Stack with 3 Resource> 
    ##  
    ##   Resources:  
    ##  
    ## <CKAN Resource> c8d5a927-0c80-46f8-ac70-c5806de61c31 
    ##   Name: Federal Marine Bioregions
    ##   Format: ESRI REST
    ## <CKAN Resource> 89a7de4a-76cf-4797-adef-200485da9ae5 
    ##   Name: Federal Marine Bioregions
    ##   Format: ESRI REST
    ## <CKAN Resource> f2a9372e-8bdf-48da-999d-8bd29d2bef10 
    ##   Name: Federal Marine Bioregions
    ##   Format: FGDB/GDB

5.  Finally, you can download the resources with `govcan_dl_resources`.
    These can either be stored to a certain directory or load into
    session (\* this option might fail due to current issues with
    `ckanr::ckan_fetch`).

<!-- end list -->

``` r
?govcan_dl_resources
path <- paste0(getwd(),"/data/")
govcan_dl_resources(id_resources, file_formats = c("JSON", "CSV", "SHP"), where = path)
```

    ##  ---------------------------------------------------------------- 
    ##  CSV file named Commercial Salmon In-Season Catch Estimates (In Pieces) From 2004 To 2017 downloaded successfully 
    ##  path to file is: /Users/vlucet/Documents/DocumentsMBP/GitHub/rgovcan/data/CommercialSalmonInSeasonCatchEstimatesInPiecesFrom2004To2017.CSV 
    ##  ---------------------------------------------------------------- 
    ##  ---------------------------------------------------------------- 
    ##  CSV file named Data Dictionary downloaded successfully 
    ##  path to file is: /Users/vlucet/Documents/DocumentsMBP/GitHub/rgovcan/data/DataDictionary.CSV 
    ##  ----------------------------------------------------------------

``` r
# govcan_dl_resources(res_pel, file_formats = c("JSON", "CSV", "SHP"), where = "session")
```
