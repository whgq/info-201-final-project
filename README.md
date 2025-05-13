# info-201-final-project

In this repository, we aim to analyze the correlation between public opinion on immigration, policy, and apprehensions / deportations in the United States.

## Research Questions

1. How has public sentiment towards immigration in the US changed over time?
2. How has public sentiment towards immigration affected election outcomes in the US over time?
3. How has public sentiment towards immigration in the US affected immigration policy over time (measured via deporations and encounters at the border)?

## Getting Started

This repository is formatted as an Rproject. Setup can be performed manually by installing these packages:

```
tidyverse
ggmap
fuzzyjoin
biscale
sf
maps
```

A Google API key is required to generate heatmaps manually. Specify this key in the `GOOGLE_API_KEY` environment variable.

A Nix file is also included which optionally sets up a development environment automatically including dependencies for the project.

If you have Nix installed, you can run:

```bash
nix develop
```

## Datasets Utilized

In analyzing our research questions, we utilize a few datasets in `data/`. These include:

- Presidential election data by county from 2000-2020
- Google trends data regarding immigration topics from 2004 - present.
  - The topics analyzed are:
    - "cbp one"
    - "immigration"
    - "asylum"
    - "border crisis"
    - "illegal immigration"
  - Data is broken down by state, county, and city
- Deporation data from deportationdata.org
  - We utilize the "Annual apprehensions with place of origin," and, "Removals (deportations)," datasets.
  - The removals dataset ranges from 2011 - 2019
  - The apprehensions dataset ranges from 1999 - 2021

We have written several scripts to process this data in `scripts/`.

- `conv_xlsx_csv.R`: converts excel-formatted data from deportationdata.org to compressed CSV format
- `split_large_csv.R`: splits datasets from deportationdata.org into small chunks of less than 100K rows so that they can be uploaded to GitHub
- `remove_large_files.R`: removes large datasets from deportationdata.org

## Results

There was a greater correlation between search interest change for the topic "Immigration" and election results for the period 2008 - 2020 than there was for the period 2004 - 2012.

![2004 - 2012](https://github.com/dowlandaiello/info-201-final-project/blob/master/src/heat_maps/election_04_to_2012_heat_map_query_change_election_result.png)
![2008 - 2020](https://github.com/dowlandaiello/info-201-final-project/blob/master/src/heat_maps/election_08_to_2020_heat_map_query_change_election_result.png)
