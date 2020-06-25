---
title: Introduction to CWL
author: "Nathaniel Maki"
organization: MDIBL Computational Core
date: "June 21st, 2020"
---
# Introduction to CWL

## Learning Objectives

* Acquire a surface-level understanding of the Common Workflow Language
* Become familiar with editing YAML/JSON files
* Learn how to execute common bioinformatics analysis tools such as FastQC, Trim_Galore, Hisat2 on the command line
* Then learn how to run them using CWLTool paired with a user-modified YAML/JSON file

## Summary

TODO

## CWL

* In a nutshell, the Common Workflow Language, also known as CWL, serves as a medium in which to write descriptions of existing command line programs and tools, and then to string those descriptions into functional workflows
* The language requires you to pre-emptively record inputs and expected outputs, but can be very flexible in what it takes in, and what results are given
* The main benefit of using this language is its incredible portability, re-usability, and scalability
* Instead of having to deal with the environment of your host machine to run your analysis / execute your tool, you can use integrated Docker calls to download and configure images of your tool at runtime
  * Basically, to run a pipeline written in CWL, all you need to have installed is CWLTool and Docker
  * Important to note, edits do need to be made to the accompanying YAML/JSON configuration file to properly pass in whatever files and program parameters you want to run your pipeline with.
  * However, you only need to do this once, and once edited, you have a saved record of what settings you used, and what tools, in what order, and which files were provided for input
* Because of the above attributes, CWL has seen adoptions in fields such as Astronomy, Machine Learning, and Bioinformatics

## YAML/JSON

* These are human-readable data transfer languages, and interchangeable with one another (serve the same purpose, syntactically similar)

### JSON Example
```json
{
  "genomeDir": {
    "class": "Directory",
    "path": "/data/transformed/STAR-2.6.1b/ensembl/release-93/danio_rerio-genome"
  },
  "fq1": {
    "class": "File",
    "path": "/data/internal/JimCoffman/jcoffman_006.abOnly_cortisol_2018/0AB1_S1_LALL_R1_001.fastq.gz"
  },
  "fq2": {
    "class": "File",
    "path": "/data/internal/JimCoffman/jcoffman_006.abOnly_cortisol_2018/0AB1_S1_LALL_R2_001.fastq.gz"
  },
  "nthreads": 8
}
```
### YAML Example
```yaml
genomeDir:
  class: Directory
  path: "/data/transformed/STAR-2.6.1b/ensembl/release-93/danio_rerio-genome"
fq1:
  class: File
  path: "/data/internal/JimCoffman/jcoffman_006.abOnly_cortisol_2018/0AB1_S1_LALL_R1_001.fastq.gz"
fq2:
  class: File
  path: "/data/internal/JimCoffman/jcoffman_006.abOnly_cortisol_2018/0AB1_S1_LALL_R2_001.fastq.gz"
nthreads: 8
```
## FASTQC
