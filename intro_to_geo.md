---
title: Introduction to GEO
author: "Nathaniel Maki"
date: "May 25th, 2020"
---
# Introduction to GEO

## Learning Objectives
* Acquire a sense of what the GEO is used for, and why it's important
* Become familier with GEO Datasets and Profiles
* Learn how to construct a GEO query, and download expression data directly to either a local or remote machine

## What is GEO?

<p>

The Gene Expression Omnibus, also known as GEO, is a vast online repository of expression data. It is primarily composed of user submitted experimental microarray and next-generation sequencing data, but also contains permutations of experimental data; curated and expanded upon by NCBI in the forms of GEO Datasets and Profiles. In addition to functioning as an experimental archive, NCBI provides a robust suite of tools for further analysis and exploration of submitted data.

</p>

<p>

GEO integrates the incredibly powerful Entrez query system to assist with parsing through the multitude of records hosted on the site. Building upon that, there are also links embedded which lead to any relevant biomedical literature hosted on PuBMed, original sequence files located in the Sequence Read Archive (SRA), and to any other of the 39 repositories maintained by NCBI.

</p>

## Getting Started

* **When working with NCBI, it's important to have an account and to be signed in**
* By doing so, your search history is saved and you're afforded considerably more compute when working with any databases API, among a plethora of other benefits, including suggested queries
* If you plan on submitting data to GEO, or other data repositories, you're required to sign in anyway, so it's a good practice to get into

<img src="./geo_images/geo_start.png">

You'll notice that the GEO homepage is roughly divided into 4 components:
* Getting Started
  * provides an overview of GEO as a whole, as well as DataSets, Profiles, and how to build queries and download data
* Tools
  * includes utilities and sites for querying DataSets, Profiles and Documentation, as well as guides on on working with the API and FTP site
* Browse Content
  * in a nutshell, a repository browser broken up into the types of submitted content on GEO (DataSets, Series, Platforms, and Samples)
* Information for Submitters
  * various guidelines and standards required for the submission of data to the GEO repository

#### 

## Content Breakdown

<p>

### Data stored in GEO is broken up into two main components:

* Original user-submitted records (in the form of Platform, Sample, and Series)
* Curated records (DataSet, and Profile)

#### The user-submitted material is fairly straightforward: 

* Platform records contain summaries of sequencer or arrays used
  * Can reference many Samples
* Sample records describe all the conditions surrounding how a singular sample was handled, the treatment that was applied to it, and abundance measurements
  * Can only reference one Platform, but can exist in multiple Series
* Series records bring together a group of related Samples and provides a central point and description of the study 
  * Can contain tables describing extracted data, summary conclusions, and/or analyses

#### Curated records are a bit more involved: 

* DataSets make up the NCBI curated collection of GEO samples that are both statistically and biologically comparable
  * Samples contained in a Dataset will all point to the same Platform, meaning they have a similar set of elements
  * Background data processing and normalization are uniform across the whole dataset
  * While you can look for Series and DataSets through the GEO Datasets interface, only Datasets come bundled with advanced data display and analysis tools
  * Because of a backlog in the generation of DataSets, not every Series has an accompanying DataSet record
* Profiles are derivatives from DataSet, and are comprised of gene expression measurements
  * Made up of expression measurements for an individual gene over all Samples that exist in a DataSet

</p>
  


