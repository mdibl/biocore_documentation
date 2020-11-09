# MINOTA Workshop November, 2020: Organizing and managing scientific data

## Workshop objectives

* Gain basic understanding of best practices when working with and managing scientific data.

## Supporting Video Tutorials
This document is supported by a series of videos that cover roughly the same content. The video references are described below:

1. [Organizing scientific data - intro](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/EalFHcQlLehJowbSv4Y-vI4Bj6OlCpl1_wWS5DSzqoT7sA?e=9ke9cD) In this video clip we talk about the importance of your data and the Biocore team's approach to organizing research data.
2. [Organizing sample data](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/ER9DHgjuS5FBmYBH_3prRq0BePG9v1tyAFZ3GN594LOAHQ?e=BJ28yN) In this video clip we discuss the organization of sample data.
3. [Organizing analysis results](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/EYCc7I9QgCFCg2a7y5uc-gEBjkJ-Tw35iEJ9z3XiTiKZSQ?e=Msk7fr) IN this video clip we talk about the organization of analysis results.
4. [Organizing pipeline scripts](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/EcXxh2dSKndKpD9ED-jF6KMBU_HlWA8OzCtVGa4am1q-jA?e=bvGAbe) In this video clip we talk about the organization of workflow and pipeline scripts.
5. [Organizing reference and transformed data](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/EWg0ABgCoGBFgfCPbXRh-mIB453kJna6gmiQjtgZuV1aqA?e=XNh158) This video clip contains real-time examples for the commands `mkdir` and `rm`.
6. [Managing pipeline scripts and ensuring reproducibility](https://mdibl-my.sharepoint.com/:v:/g/personal/cwilson_mdibl_org/ETeaz2TvlVhEslS-3zlHRUIBdx4eI67dU9crYKhjVCQ97Q?e=1NSkFD) In this video clip we talk about managing configuration files used in a workflow or pipeline analysis.

It is recommended that you references these videos in order then use this guide as an additional "follow along guide" or future reference.

## Supplemental Resources
This workshop series will explore a variety of Linux terminal commands. We will start with some of the most basic commands and progress up from there. The [resources](resources) section at the end of this document contains a list of supplemental resources that you can reference at any time during this workshop series and after.

## Preliminary requirements

In this tutorial, we will make several assumptions:
1. Your computational work requires a Unix/Linux based operating system.
2. You are familiar with the Linux operating system.
3. You are familiar with the command-line as the primary interface for interacting with the Linux operating system.

If you need to familiarize yourself with Linux and or the command-line interface, please reference these tutorials before continuing.

[Introduction to the terminal, navigating the Linux file system](https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/markdown/workshop_intro.md)

[Introduction to the terminal, navigating the Linux file system: Supplemental Information](https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/markdown/workshop_intro_sup.md)

[Secure Shell (SSH) with Username and Password](https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/markdown/workshop_ssh_password.md)

[Secure Shell (SSH) SSL Key Generation](https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/markdown/workshop_ssh_sshkeys.md)

## Working with remote computational resources

Bioinformatics tools such as Trinity or STAR can require computational
resources that your laptop or desktop computer does not have. Depending on the
number of reads for example, Trinity can require in excess of 100GB of RAM to
perform an assembly. Similarly, depending on the organism, STAR can require in excess of 250GB of RAM to perform an alignment.

For the purpose of the MINOTA workshop, the MDIBL Biocore will use
computational resources provided by Amazon Web Service (AWS). These resources
will be configured and managed for you. Initially, you will be provided with resources needed to carry out the most computationally expensive portion of a transcriptome analysis which is the assembly. Once the assemly is complete, the resources will be reconfigured with more modest resources suitable for the remaining analysis.

When working with remote compute resources, you will often be required to move or copy your data to that resource. Secure copy `scp` and `rsync` are two tools most commonly used to move data between Linux-based operating systems.

A turorial on these tools can be found here [scp and rsync: Working With Remote Data](https://github.com/mdibl/biocore_documentation/blob/master/cli_workshops_2020/markdown/workshop_remote_data.md).

**Please note**, all sample data required for the MINOTA workshop is preinstalled installed on the computational resources provided by the MDIBL. However, if you are interested in working with your own data set(s), you will need to copy that data to the resources. If you not familiar with either `scp` or `rsync`, it is a good idea to familiarize yourself with these tools.

## Organizing your research data 

Most federal funding agencies (NIH, NSF, DOE, etc.) define "data" as anything needed to reproduce the results you have assertained. By definition, this includes computer/model code and appropriate parameters as well as versions of the tools used to conduct your research. 

Bioinformatics research will typically involve numerous files of different file types. This can include multiple sample files, reference data sets and various output files that are created during an analysis. It is recommended that you establish and adhere to a data storage and data naming convention that allows you to streamline your analysis as much as possible and maintain reproducibility. 

The MDIBL Biocore team has established an internal data management
specification that we will adhere to the purpose of the MINOTA workshop. An explanation of this specification is detailed in the following sections.

## The /compbio directory structure 

The MDIBL Biocore team organizes all sample data, reference data and computational tool scripts under the directory `/compbio`. This directory contains the following sub-directories:

1. `/compbio/data`,
2. `/compbio/analysis`,
3. `/compbio/cwl`,
4. `/compbio/reference`
5. `/compbio/transformed`,

## Organizing Sample Data `/compbio/data`

As you conduct your research, it is good practice to organize your sample data in a way that allows you to easily find and reanalyze that data. The Biocore team at MDIBL organizes all sample data beneath a single "data" directory namely, `/compbio/data`.

The Biocore team organizes all sample data into sub-directories beneath `/compbio/data`. each sub-directory is named after the project leader. For example, all sample data for Lara Croft would live under `/compbio/data/LaraCroft/`. 

Sample data is further organized into project subdirectories where each project directory contains a shortened version of the project leader followed by a project ID. For example, sample data for one of Lara Croft's projects might live under `/compbio/data/LaraCroft/lcroft_001/`. When additional project information is supplied or required, that information will be appended to the project name. For example `/compbio/data/LaraCroft/lcroft_001.tomb_1`. 

While this naming scheme specific to our process here at MDIBL, it is good practice to establish a well-defined organization and naming scheme for yourself. This can greatly reduce the chance of misplaced data or worse, data corruption. **Please note**, some computational tools will happily overwrite an existing directory with new data which can result in lost work and time. 

**Please note**, for the purpose of the MINOTA workshop, the Biocore team has initialized `/compbio/data` with a variety of sample datasets ranging in size and complexity. All datasets for the MINOTA workshop live under `/compbio/data/MINOTA`. This includes minota_001,  minota_002,  minota_003, minota_004 and minota_005. 

## Organizing Analysis Results `/compbio/analysis`

When performing an analysis, the tools you use can generate many files. To avoid confusion and unnecessary clutter, you should store the results of an analysis separately from your sample data. The Biocore team stores all analysis data under `/compbio/analysis`. 

Much like `/compbio/data/`, all data in `/compbio/analysis/` is organized according to the project leader with all analysis results further organized by project. These directories mirror those under `/compbio/data`. For example, all analysis results for Lara Croft's tomb_1 sample will live under `/compbio/analysis/LaraCroft/lcroft_001.tomb_1`. For the purpose of the MINOTA workshop, all analysis results should be stored under `/compbio/analysis/MINOTA`.

## Organizing Computational Workflow and Pipeline Scripts `/compbio/cwl`

There can be many steps involved when performing a traditional RNA seq or a
transcriptome assembly. To complicate things further, there can be multiple
tools for performing some steps. For example, there are multiple tools that can be used to perform an assembly and there are multiple tools that can be used to perform an alignment. In general, all tools will require you to specify a path to your input data and specify the path to where you want the results to be saved. However, some tools will require additional parameters such as how much memory to consume or how many processors to use as well as any parameters that are specific to the functionality of that tool.

For tools with a large number of input parameters, manually executing these commands from the command line can be cumbersome. Worse yet, it can be difficult to remember or decipher the parameters you used during a specific component of your analysis. This can impact your ability to execute pipelines in a manner that is efficient and allows you to re-create your results should the need arise.

The MDIBL Biocore team uses Common Workflow Language (CWL) to manage the
configuration and execution of bioinformatics pipelines. CWL allows you to
define computational workflows and pipelines in a scriptable and templateable manner, providing for better workflow and pipeline management.

**For a comprehensive discussion on CWL please visit the following tutorial on CWL.**

[Introduction to CWL](https://github.com/mdibl/biocore_documentation/blob/master/intro_to_cwl.md)

The MDIBL Biocore team organizes all workflow and pipeline CWL scripts under the `/compbio/cwl` directory. For the purpose of the MINOTA workshop, the Biocore team has initialized the `/compbio/cwl` directory with a suite of tool scripts and configuration templates that can be used to perform an assembly pipeline.

Each script and configuration file is named according to a tool. For example, the CWL script and configuration for FastQC would be named `/compbio/cwl/fastqc.cwl` and `/compbio/cwl/fastqc.yaml` resepectively.

## Managing pipeline configurations

The scripts in `/compbio/cwl` should not be modified. They are intended to be called or executed "in place". That is, when invoking a CWL script you should call the appropriate tool script from the `/compbio/cwl` directory. For example, when running FastQC, you would execute the command `cwltool /compbio/cwl/fastqc.cwl <path_to_your_config>`. This ensures the tool script for CWL is unmodified and can be reused without unwanted consequence.

The configuration files provided in `/compbio/cwl` are intended to be tailored to a specific analysis. In fact, these files, along with details of the tools used (e.g., tool version, etc.) can be used to define a pipeline should your results need to be replicated.

Unlike CWL scripts, tool configurations (e.g., fastqc.yaml) are not intended to be modified or used "in place". Rather, you should **copy** a configuration file to an alternative location, then modify the copy. This ensures there is a working template file available for each tool.

### Ensuring reproducibility

As we mentioned above, your workflow or pipeline configuration is critical to reproducing your results. To ensure reproducibility, it is a good practice to save the configuration files used to run a pipeline analysis in a conspicuous location. The Biocore team stores the configuration files specific to a workflow or pipeline in a directory called `config` under the appropriate project analysis directory. For example, configuration files for Lara Croft's analysis would live under `/compbio/analysis/LaraCroft/lcroft_001.tomb_1/config`.

Whether you copy a configuration file to the appropriate `config` directory then edit it in place or you edit your configuration file in another location, you should ensure your configuration file is transferred to the appropriate `config` directory before pipeline execution. This allows you to reference that file in place when running your scripts. In this case, executing a CWL script might look like 

`cwltool /compbio/cwl/fastqc.cwl /compbio/analysis/LaraCroft/lcroft_001.tomb_1/config/fastqc.yaml`

## Organizing reference data `/compbio/reference`

When working with organisms that have a reference genome available (e.g.,
yeast, zebrafish), it is good practice to store the reference data in a
conspicuous location. The MDIBL Biocore team organizes available reference data
under `/compbio/reference`. All reference data is organized by the producer,
the version and finally, the organism. For example, reference data for
zebrafish would live under `/combio/reference/ensembl/release_100/danio_rerio`.

## Transformed data `/compbio/transformed`

In many cases, reference data will need to be pre-processes or transformed before to make it more useful. As Dr. Joel Graber of the MDIBL Biocore states: "many analyses in our field are optimized by preprocessing the reference data in some way to make the analysis of new or unknown data more rapid and efficient." Alignment is just one example of preprocessing reference data. 

Much like other data used in a workflow or pipeline analysis, it's good to store that data in a conspicuous location so it can be easily referenced.
The Biorcore team stores all pre-processed or "transformed" data in `/compbio/transformed`. All transformed data is organized by the tool used to perform the pre-processing or transformation. Data is further organized according to the original reference data set. For example, the result of aligning zebrafish data using STAR would be stored under `/compbio/transformed/STAR-2.6.0/ensemble-100/danio_rerio`


## Contact
If you have questions about the information in this workshop document, please contact:

```
Chris Wilson
Bioinformatics Software Engineer
MDI Biological Laboratory
cwilson[at]mdibl.org
```