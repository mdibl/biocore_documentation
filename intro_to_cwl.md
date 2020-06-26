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
* Learn how to execute common bioinformatics analysis tools such as FastQC, Trim_Galore, and Hisat2 on the command line, through the use of CWL scripts and a configuration file

## Summary

* The analysis work we do in the MDIBL Computational Core can be boiled down to a few key components/tools/languages, two of which we will be discussing today (CWL and JSON/YAML)

## CWL

* In a nutshell, the Common Workflow Language, also known as CWL, serves as a medium in which to write descriptions of existing command line programs and tools, and then to string those descriptions into functional workflows
* The language requires you to preemptively record inputs and expected outputs, but can be very flexible in what it takes in, and what results are given
* The main benefit of using this language is its incredible portability, re-usability, and scalability
* Instead of having to deal with the environment of your host machine to run your analysis / execute your tool, you can use integrated Docker calls to download and configure images of your tool at runtime
  * Basically, to run a pipeline written in CWL, all you need to have installed is CWLTool and Docker
  * Important to note, edits do need to be made to the accompanying YAML/JSON configuration file to properly pass in whatever files and program parameters you want to run your pipeline with.
  * However, you only need to do this once, and once edited, you have a saved record of what settings you used, and what tools, in what order, and which files were provided for input
* Because of the above attributes, CWL has seen adoptions in fields such as Astronomy, Machine Learning, and Bioinformatics

**This tutorial assumes that you already have CWLTool and Docker installed locally or on a remote machine**

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

## Editing Configuration Files

* Before we can start working with CWL directly, it's important to first get a grasp on how to edit the configuration files needed to successfully execute a wrapped tool
* As mentioned above, they can be written in either the JSON or YAML language
* To access the scripts and config files for this tutorial, clone the biocore_documentation repository found [here](https://github.com/mdibl/biocore_documentation)
  1. To clone, simply click the `Clone` button on the main repo page, and copy the link provided in the `Clone with HTTPS` box
  2. Next, open up the terminal, navigate to where you'd like to place these tutorial/documentation files on your remote machine, and type the following
  3. `Git clone` followed by pasting the repo link you copied earlier
  
* Once you've cloned the repository, `cd` into `biocore_documentation`
  * Then `cd` into `cwl_tutorial_files`
  * From there, `cd` into `configuration`
  * To view the contents of this directory, use the `ls -al` command
  * Under this directory you will see a couple tool-specific YAML files, including one for FastQC and trim_galore
  * The easiest (well, quickest) way to edit these files is through a built-in text-editing program such as Vim or nano (for this example, we'll use nano and the FastQC-test.yaml)

### Using nano

* To edit the YAML file, type `nano FastQC-test.yaml` into the command line
  * This will open the file in the nano text editor
* At the top of the page are the contents of the file, and at the bottom, the list of commands available to you
  * Use the arrow keys to move to the line that says `path: "/compbio/data/test_fastq/KO_cort2.fastq"`
  * Move along the length of the line to `/KO_cort2.fastq`
  * Edit the path so that instead of reading `/KO_cort2.fastq`, it reads `/KO_cort1.fastq`
* Once that change has been made, use the `control` and `o` key to write out
  * Type `y` to save the changes you made to the file
* Exit the nano text editor by using the `control` and `x` keys

Great! You've successfully edited a configuration file to point to a new sequence!

Now we can use the CWL-wrapped FastQC tool to generate a quality report of the sequence file specified.

## FastQC

* FastQC is a widely used tool that conducts quality control checks on sequence data generated by HTS
* Capable of generating HTML reports from BAM, SAM, and/or FastQ files
* Provides a descriptive overview highlighting where there may exist problems in your data
* Can be ran either as a GUI program, or completely on the command line
  
### Using FastQC via CWL

Before we execute the CWL script, we first want to create a named directory for our analysis.

* `cd` into the `/compbio/analysis` directory
  * then use the `mkdir` command to create a named directory for your output
  * i.e `mkdir nmaki`
* `cd` into your new directory, and you're now ready to execute some CWL code
  * on a side note, you can also create tool specific directories such as `fastqc-test` to avoid clutter, but it's up to personal preference
  
To run the FastQC tool with the configuration file we edited, use the following command:
`cwltool ~/biocore_documentation/cwl_tutorial_files/code/FastQC.cwl ~/biocore_documentation/cwl_tutorial_files/configuration/FastQC-test.yaml`
* This will use CWLtool to invoke FastQC, and pass in the wrappers required inputs via the YAML file
* `~/` brings you to your home directory, and the rest are just the locations of the two components; CWL script and config file

As the sample sequences are fairly small in size, the run should complete fairly quickly.

You can now use `ls -al` to view the generated files, and unzip the FastQC output through the `unzip` command

## Contact

If you have questions about the information in this workshop document, please contact:

```
Nathaniel Maki
Bioinformatics Research Training Specialist
MDI Biological Laboratory
nmaki[at]mdibl.org
```