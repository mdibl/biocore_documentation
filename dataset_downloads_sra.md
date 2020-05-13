---
title: Working with the SRA and the SRA Toolkit
author: "Nathaniel Maki"
date: "May 12th, 2020"
---
**add images to improve guide**
## What is SRA?
The Sequence Read Archive, or SRA, is an online archive for raw sequence data, generated from next generation sequencing tech such as Illumina, PacBio, and IonTorrent.

It is also the National Institute of Health's (NIH) primary repository for high throughput sequencing data.

## What is the SRA Toolkit?
The SRA Toolkit is a suite of compiled binaries and source code for tools that download, manipulate, and validate next generation HTS data stored inthe SRA archive.

## Learning Objectives
* Become comfortable working with the SRA, navigating through the site, and acquiring SRA data
* Explore the SRA Toolkits' various functions and utilities
* Using an SRA accession file, download corresponding experimental fastq data from archive

## Installing SRA Toolkit
Lets get this out of the way first:
* [Click this link view the Download page](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software)
* Compiled binaries exist for macOS and RHEL/Ubuntu based Linux distributions
* If running Windows (follow up with guide to install WSL Ubuntu 20.04)
  * The above is only needed if you want to use the newest binaries (as of date, 2.10.5)
  * Otherwise, just use Toolkit version 2.9.6-1
* Unzip the tar.gz file
  * if using macOS or Windows, either double click or right click and select extract
  * for Linux use `tar -xzf sratoolkit.version-ubuntu_linux64.tar.gz`
* If you are working from the command line, you can utilize the NCBI FTP site and download the Toolkit via `wget https://ftp.ncbi.nlm.nih.gov/sra/sdk/2.10.5/sratoolkit.2.10.5-ubuntu64.tar.gz`

## Alternative: Using Brew
It took me some time to install sratools through NCBI documentation, so here is another, easier, method.
Instead of going through the process manually, you can install it using Homebrew, an (imo fantastic) package manager for macOS and Linux
* To install Homebrew, just past the following into your terminal: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
* Once homebrew is installed, you need to add the tap brewsci/bio
  * This contains tons of bioinformatics packages, with one included being sratoolkit
  * Simply type `brew tap brewsci/bio` in the command line
  * Once added, follow up with `brew install sratoolkit`
* Installing sratoolkit in this fashion adds it to your PATH (which normally you have to do manually), and you can immediatly progress with the next component of this tutorial
* In a nutshell, adding a program to PATH allows you to use it anywhere in the filesystem, not just in the location in which it's located.
  * Instead of having to give a direct path to fastq-dump like this: `~/sra-toolkit/bin/fastq-dump.2.10.5 -X`
  * You can immedially use it like so: `fastq-dump -X` on the command line

## Downloading data from SRA
**Include image for below**
The Sequence Read Archive can be broken into four main levels, each with their own specific accession IDs
* Studies: DRP, ERP, SRP accessions
* Samples: DRS, ERS, SRS accessions
* Analyses: DRZ, ERZ, SRZ accessions
* Run: DRR, ERR, SRR accessions

The smallest unit able to published in the SRA is an Analysis

<img src="./images/sra_structure_infograph.png" width="600">

**will introduce GEO before SRA**
For this example, we are going to be focusing on data from a study (publication) through GEO, 
