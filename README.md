# info-201-final-project

In this repository, we aim to analyze the correlation between public opinion on immigration, policy, and apprehensions / deportations in the United States.

## Getting Started

This repository is formatted as an Rproject. A Nix file is also included which sets up a development environment including R and dplyr, which we utilize.

## Datasets Utilized

In doing so, we utilize a few datasets in `data/`. These include:

- Presidential election data by county from 2000-2020
- Google trends data regarding immigration topics from 2004 - present.
  - The topics analyzed are:
    - "cbp one"
    - "Mexico-United States Border"
    - "U.S. Customs and Border Protection"
    - "Border"
    - "Immigration"
  - Data is broken down by state, county, and city
- Deporation data from deproationdata.org
  - We utilize the "Annual apprehensions with place of origin," and, "Removals (deportations)," datasets.
  - The removals dataset ranges from 2011 - 2019
  - The apprehensions dataset ranges from 1999 - 2021
