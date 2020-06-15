---
title: Introduction to GEO
author: "Nathaniel Maki"
contact: nmaki@mdibl.org
organization: MDIBL Computational Core
date: "May 25th, 2020"
---
# Introduction to GEO

## Learning Objectives

* Become familiar with what GEO is used for, and how it can supplement research
* Understand the difference between user-submitted and NCBI curated material
* Learn how to construct a GEO query, and download expression data directly to either a local or remote machine

## Summary

* The Gene Expression Omnibus, also known as GEO, is a large online repository of expression data 
* Primarily composed of user submitted experimental microarray and next-generation sequencing data 
* Also contains permutations of experimental data; curated and expanded upon by NCBI in the forms of GEO Datasets and Profiles
* In addition to functioning as an experimental archive, NCBI provides a robust suite of tools for further analysis and exploration of submitted data
* Records include embedded links which lead to relevant biomedical literature hosted on PuBMed

## Logging in / Creating an NCBI Account

#### Having an NCBI account greatly increases the flexibility of the tools and resources at your disposal.

* This includes working with NCBI's programming API:
  * With a verified account, your API calls are not throttled, and you're afforded more compute than if you were to remain anonymous
* Assists in searching for and submitting through NCBI:
  * Saving of search strategies and queries built through PubMed and other repositories
  * You're required to have an account for data submission
* To sign in/create an account, click this [link](https://www.ncbi.nlm.nih.gov/account/?back_url=https%3A%2F%2Fwww.ncbi.nlm.nih.gov%2F)

## Platform Overview

<img src="./geo_images/geo_start.png" width="1000">

The GEO homepage is comprised of 4 components:
* Getting Started
  * Provides an overview of GEO as a whole, as well as DataSets, Profiles, and how to build queries and download data
* Tools
  * Includes utilities and sites for querying DataSets, Profiles and Documentation, as well as guides on on working with the API and FTP site
* Browse Content
  * Repository browser broken up into the types of submitted content on GEO (DataSets, Series, Platforms, and Samples)
* Information for Submitters
  * Various guidelines and standards required for the submission of data to the GEO repository

## Content Breakdown

* Original user-submitted records
  * Platform
  * Sample
  * Series
* Curated records
  * Dataset
  * Profile

## User-Submitted records

### Platform

* Platform records contain summaries of sequencer or arrays used
* May reference many Samples

<img src="./geo_images/geo_platform_browser.png" width="1000"> 

### Sample

* Sample records describe all the conditions surrounding how a singular sample was handled, the treatment that was applied to it, and abundance measurements
* May only reference one Platform, but can exist in multiple Series

<img src="./geo_images/geo_samples_browser.png" width="1000">

### Series

* Series records bring together a group of related Samples and provides a central point and description of the study 
* May contain tables describing extracted data, summary conclusions, and/or analyses

<img src="./geo_images/geo_series_browser.png" width="1000">

## Curated records 

### Dataset

* DataSets make up the NCBI curated collection of GEO samples that are both statistically and biologically comparable
  * Samples contained in a Dataset will all point to the same Platform, meaning they have a similar set of elements
  * Background data processing and normalization are uniform across the whole dataset
  * While you can look for Series and DataSets through the GEO Datasets interface, only Datasets come bundled with advanced data display and analysis tools
  * Because of a (massive) backlog in the generation of DataSets, not every Series has an accompanying DataSet record

<img src="./geo_images/geo_dataset_browser.png" width="1000">

### Profile 

* Profiles are derivatives from DataSet, and are comprised of gene expression measurements for an individual gene over all Samples that exist in a DataSet
  
### GEO Datasets
* Built from user submitted records, including Series, Samples, Platforms
* Also stores curated gene expression + molecular abundance data put together by NCBI
* Records additionally contain resources and tools, such as clustering utilities and multi-sample comparison

#### GEO Dataset Results page:

<img src="./ncbi_images/GEO_datasets_results.png" width="800">

* Title of each individual dataset lists either the Dataset (GDS), Series (GSE), or Platform (GPL) accession number
* Followed by Title, and Organism in brackets
* Underneath Accession number are quick links to the GEO Profiles, PMC text, and tools for analysis
* Clicking the main title brings you to the Dataset Record

#### GEO Dataset Records page:

<img src="./ncbi_images/GEO_dataset_record.png" width="800">

* Main record contains descriptive information about the dataset (organism, platform, sample values + number)
* Next to the record, the Expression Profiles link takes you to the GEO Profiles page
* Cluster Analysis to the right brings you to the requisite heatmap
* Under that are options to download various files containing additional Dataset information, experimental variable subsets, etc
* At the bottom are additional data analysis tools for finding genes, comparing sets of samples, generating heatmaps, and examining experimental design + value distributions.

### GEO Profiles
* A derivative of Geo Datasets
* Stores *individual* curated gene expression + molecular abundance profiles
* Assembled and sourced from GEO microarray data
* Queries based upon gene annotation / profile characteristics

#### GEO Profile Results page:

<img src="./ncbi_images/GEO_profile_results.png" width="800">

* Lists Dataset accession (GDS) from where the profile is derived from
* Platform accession (GPL) that the Dataset is based on + unique ID from record
* Organism
* Additionally, contains:
  * Annotation: gene symbol, full name + aliases
  * Reporter: Original sequence reporter(s) taken from the Platform record supplied by submitter
  * Experiment: Dataset from where the profile comes from

#### GEO Profile Chart page:

<img src="./ncbi_images/GEO_profile_record.png" width="600">

* By clicking on the little chart thumbnail, the full profile details are enlarged
* This expanded chart include more comprehensive details, such as expression values and experimental design
* Explaining the graph:
  * Each column you see represents the expression measurement that was extracted from the VALUE column of the Sample record
  * Original Sample accessions are listed below (GSM)
  * Something to note: The values associated with each accession have undergone processing and normalization that is not uniform across accessions.
  * Because of this, the values should be considered arbitrary, and direct comparisons between different Datasets may not be accurate.
  * The square represent rank order of expression measurements, and indicate where the expression of that gene falls in comparison to all other genes on an array.

#### GEO Sample Accession

<img src="./ncbi_images/GEO_sample_accessions.png" width="800">

* Selecting a Sample in the Profile Chart brings you to it's appropriate GEO Accession page
* Here, you can view tons of relevant information in regards to the singular Sample including: 
  * Sample type
  * Source name
  * Organism
  * Various characteristics
  * Protocols used for Treatment, Growth, Extraction, etc
* Also includes the Platform ID (GPL) and Series ID at the bottom
* You also have the option to download raw Sample specific CEL data, either through a web browser, or through FTP

## Contact

If you have questions about the information in this workshop document, please contact:

```
Nathaniel Maki
Bioinformatics Research Training Specialist
MDI Biological Laboratory
nmaki[at]mdibl.org
```


