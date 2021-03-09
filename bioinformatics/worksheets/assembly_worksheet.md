---
title: Transcriptome Assembly Worksheet
author: Nathaniel Maki
organization: MDIBL Computational Core
date: March 1st, 2021
---

# Transcriptome Assembly Worksheet

## Learning Objectives

* Improve skills in filesystem navigation and file modification through the use of the CLI and nano
* Through the Bowdoin SGE Compute Cluster, use a Trinity script in conjunction with Commander to generate a basic transcriptome
* Understand the options contained within the Trinity script, and how they can impact your resulting Assembly

### Step 0: Connecting to the Cluster

This step has been covered in a previous lecture, and is required to proceed with this worksheet

In short, ensure that you've connected to the Bowdoin VPN, have logged into Moosehead, and that your terminal is displaying the following

<img src="./assembly_worksheet_img/img1.png" width="800">

### Step 1: Navigating through the Cluster ( where are all the things :thinking: )

The path to your specific User directory is `/mnt/courses/biol2566/people/` followed by your username

This User directory will be automatically populated with `Analysis`, `Data`, etc by Commander, and scripts you launch will dump their output here, in a predictable, findable, and structured format

We're going to be editing some template files to point towards your specific directory structure, but first, we need to retrieve them

Those template files can be found at `/mnt/courses/biol2566/software/compbio_commander/paramfile_templates`

### Step 2: Copying Template files to qsub directory

First, create a directory called `qsub` in your home directory (reached by typing `cd ~`)

* `mkdir qsub`
* `cd` into `qsub`

Copy the template json files we've provided from the above path to the `qsub` directory

* `cp /mnt/courses/biol2566/software/compbio_commander/paramfile_templates/*.json ./`

### Step 3: Editing the Trinity json file

First, we're going to want to give the template file a more unique name

Using the `mv` command, change the name of the `bowdoin_trinity_template.json` file to `"username"_trinity_template.json`

* `mv bowdoin_trinity_template.json` `nmaki_trinity_template.json`

Now open the named `trinity_template.json` in `nano`

The default file will look like this:

```
{
	"job_details": {
		"job_name": "ENTER_YOUR_JOBNAME_HERE"
	},
	"experiment_details": {
		"pi": "PI_NAME",
		"experiment_name": "EXPERIMENT_NAME",
		"analysis_id": "ANALYSIS_ID",
		"sample_path": "/mnt/courses/biol2566/data",
		"analysis_path": "/mnt/courses/biol2566/people/YOUR_USERNAME/analysis",
		"workdir": "/mnt/hpc/tmp/YOUR_USERNAME",
		"sample_file": null,
		"sample_file_type": null
	},
	"sge_preamble":{
		"current_directory": true,
		"join_output": true,
		"email_address": "YOUR_EMAIL",
		"shell": "/bin/bash",
		"parallel_environment": "smp 16",
		"memory": "virtual_free=4g"
	},
	"misc_preamble": [
		"### ENVIRONMENT VARIABLES TO BE USED AT QSUB-SCRIPT LEVEL ONLY ###",
		"### DO NOT TRY TO REFERENCE THESE VARIABLES IN THE TRINITY COMMAND ###",
		"# Top level course space",
		"classdirectory='/mnt/courses/biol2566'",
		"",
		"# Temporary HPC directory for temporary runtime files",
		"hpctmp='/mnt/hpc/tmp/'$USER",
		""
	],
	"commands": [
		{
			"command": "Trinity",
			"batch": false,
			"tasks": 1,
			"cpus": 3,
			"memory": 128,
			"singularity_path": "$classdirectory/software/sif",
			"singularity_image": "trinity_v_latest.sif",
			"work_dir": null,
			"volumes": [
				{
					"host_path":"$classdirectory",
					"container_path":"/compbio"
				},
				{
					"host_path":"$hpctmp",
					"container_path":"/hpctmp"
				}
			],
			"options": [
				"--seqType fq",
				"--SS_lib_type RF",
				"--normalize_by_read_set",
				"--samples_file /compbio/data/PI_NAME/EXPERIMENT_NAME/SAMPLE_FILE_NAME",
				"--trimmomatic",
				"--max_memory 64G",
				"--CPU 16",
				"--workdir /hpctmp/ENTER_YOUR_JOBNAME_HERE-$JOB_ID",
				"--output /hpctmp/ENTER_YOUR_JOBNAME_HERE-$JOB_ID"
			],
			"arguments":null
		}
	],
	"cleanup":[
		"",
		"# sync and wait for a bit",
		"sync",
		"sleep 60s",
		"",
		"# copy final output file from temporary working directory",
		"cp $hpctmp/ENTER_YOUR_JOBNAME_HERE-$JOB_ID/Trinity.* $classdirectory/people/$USER/analysis/PI_NAME/EXPERIMENT_NAME/ANALYSIS_ID/Trinity"
	]
}
```

You'll need to replace anything in ALL-CAPS with details relative to your username and options that we'll define below

* Ignore the `misc_preamble`, that does not need to be modified

Lets edit the file together, moving through it block by block

The block identifier will be denoted in **bold**, with expected output following below that
#### 3.1: job_details

* Update the "job_name" entry with a new id (can be something as simple as nmaki_trinity_test)

**Expected**

```
"job_details": {
		"job_name": "nmaki_trinity_test"
```

#### 3.2: experiment_details

* Update the "pi" entry to "Bowdoin"
* Update the "experiment_name" entry to "jcoffman_001.reduced"
* Update the "analysis_id" entry to an id of your choosing (can be 0123456789)
* Update the "analysis_path" entry with your username where specified
* Update the "workdir" entry with your username where specified

**Expected**

```
"experiment_details": {
		"pi": "Bowdoin",
		"experiment_name": "jcoffman_001.reduced",
		"analysis_id": "0123456789",
		"sample_path": "/mnt/courses/biol2566/data",
		"analysis_path": "/mnt/courses/biol2566/people/nmaki/analysis",
		"workdir": "/mnt/hpc/tmp/nmaki",
		"sample_file": null,
		"sample_file_type": null
```

#### 3.3: sge_preamble

* Update the "email_address" entry to point to your email

**Expected**

```
"sge_preamble":{
		"current_directory": true,
		"join_output": true,
		"email_address": "nmaki@mdibl.org",
		"shell": "/bin/bash",
		"parallel_environment": "smp 16",
		"memory": "virtual_free=4g"
```

#### 3.4: misc_preamble

* Ignore me

#### 3.5: commands

* Ignore the entries up until the "options" block
* Update the "--samples_file" option with the details for "pi_name" and "experiment_name" respectively
  * We didn't define the "SAMPLE_FILE_NAME" previously, it is `jcoffman_001.reduced.samples.txt`
* Update the "--workdir" option with the "JOBNAME" we defined at the top of the file
* Update the "--output" option with the "JOBNAME" we defined at the top of the file

**Expected**

```
"commands": [
		{
			"command": "Trinity",
			"batch": false,
			"tasks": 1,
			"cpus": 3,
			"memory": 128,
			"singularity_path": "$classdirectory/software/sif",
			"singularity_image": "trinity_v_latest.sif",
			"work_dir": null,
			"volumes": [
				{
					"host_path":"$classdirectory",
					"container_path":"/compbio"
				},
				{
					"host_path":"$hpctmp",
					"container_path":"/hpctmp"
				}
			],
			"options": [
				"--seqType fq",
				"--SS_lib_type RF",
				"--normalize_by_read_set",
				"--samples_file /compbio/data/Bowdoin/jcoffman_001.reduced/jcoffman_001.reduced.samples.txt",
				"--trimmomatic",
				"--max_memory 64G",
				"--CPU 16",
				"--workdir /hpctmp/nmaki_trinity_test-$JOB_ID",
				"--output /hpctmp/nmaki_trinity_test-$JOB_ID"
			],
			"arguments":null
		}
	],
```

#### 3.6 cleanup

* Update the final line of the script, starting with `"cp`, with your JOBNAME, PI_NAME, EXPERIMENT_NAME, and ANALYSIS_ID using the inputs we defined in the "experiment_details" block above

**Expected**

```
"cleanup":[
		"",
		"# sync and wait for a bit",
		"sync",
		"sleep 60s",
		"",
		"# copy final output file from temporary working directory",
		"cp $hpctmp/nmaki_trinity_test-$JOB_ID/Trinity.* $classdirectory/people/$USER/analysis/Bowdoin/jcoffman_001.reduced/0123456789/Trinity"
	]
```

### Step 4: Executing Commander on edited Trinity json file

Once we've made all the necessary modification, and our script closely resembles the example above, save the changes with `ctrl + o` and then exit out of `nano` using `ctrl + x`

Next, we want to feed the json file into Commander, which will generate a bash script and allow us to run the job on our compute cluster

The command you'll want to run is as follow:

* `/mnt/courses/biol2566/software/compbio_commander/commander --sge --preflight nmaki_trinity_template.json`

If you execute an `ls` in your `qsub` directory, you'll see that we now have another file, one with a `.sh` suffix

### Step 5: Launching the Trinity shell script through qsub

To launch your shell script, simply type the following into the command line

* `qsub nmaki_trinity_test.sh`

To check on a currently submitted job, you can use

* `qstat -u "username"`

### Step 6: Examining output

Your output will be deposited in a path similar to the one below

* `/mnt/courses/biol2566/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/Trinity`

The names of the directories that have been auto-generated rely upon the parameters given in the json script 

Some of these folders may differ depending upon what you called them

Assuming that everything has ran properly, running an `ls` in the `Trinity` directory should yield three results

* Trinity.fasta
* Trinity.fasta.gene_trans_map
* Trinity.timing

#### 6.1 Trinity.fasta

Running the `head -n 5` command on the `Trinity.fasta` file will give us a look into what constitutes our transcriptome assembly

```
>TRINITY_DN30_c0_g1_i1 len=259 path=[0:0-258]
TTATTATGTCTACAAGTTTACCAGGCCTCCTCTTTCAATCCCAGTTCCAAGATATTGTGCAGTGTCTTTCCCCACCCCAAGTGTCGACCCCTGCGACAACTACATCAGTCTGGATGATCCTTGGAGATCCACTGAAAACCCTGCTAACTACTATAGCTTTTGTGATTGGGGTAATTCATGGAATGGCTTTTACAGGCTGTTCTACAACAGTCAGAGTGCTCAAATGCCAGAATCATGTGTAAATGAAGGCATGTGTGGC
>TRINITY_DN30_c0_g2_i5 len=1272 path=[0:0-149 2:150-278 3:279-286 5:287-287 7:288-294 8:295-1271]
CCGAGATTTTGCGCAGCTTACTGTGTTGCTGCAAACCAGTCCAGCACAGCCGTGACAACAACCCAGCCAATCACAACCATAGACTTCATTAATCCACCAACCACTGCTCCCCCTGTTGACCCCTGCAATAACTTCTTGATCCTGGATGAACCATGGAGAGCCACCAGCAATCAAAACTCCTCTCAGTTAATGTGTGACAGTGCGGTGAGCTGGAGCGGCTGGTACCGTCTCTTCATTAATGGTCAGAGTGTTCAGATGCCAGACACATGTGTTGATGAGAATAGCTGCGGCACTAATGCTCCACTGTGGCTGAGCGGAGGACATCCAACACTTGAGGATGGAGTGGTCTCTCGTAATGTCTGCGGACACTGGAACAACGACTGCTGCTATTTCCAGTCCAATCCCATTCAAGTCAAAGCCTGTCCTGGAGGTTTTTATGTCTATGAGTTTGTGAGGCCGACCACCTGCAATTTAGCATACTGTGCAGATGTGAGGTTTAACACTAGCTATACAACTGACATACCAGAGACGACCACAACAGAAACAGCAGCTGAAACCAGAACTATAATATTTGATGACAGAAACCCCTGTTCTGAACTCAACTGCTCCAAAGAGGAAAGGTGTGGGATGAAAAATGGTGTTTATGGCTGTTTATGTAACAAAGGCCACCAAAAACAGCGAGCAGCTCAAGACTCCTTTGATTTCAATGAGACCTGTGAGAGCAGCTCTGGCTCCATGTCTGTGTCTCGCTGTCAGCTTTTTGAAGCTGGTTTTTCAGCTGAGCACTTACACCTCAATGACCCCAGCTGCAGAGGAACCGTCCAGAACGGCAGAGTGGAGTTTAACTTCGACAACGATCAACACATCTGTGGCACAAATCTTGTGGCCAACGGCAGCCACTTCATCTACAGTAACTATATTGTGGGGACGCCGGGAACAGAAGGTCTCATCAGCAGAGTGAGAATCCTGAAGCTTTCTTTCAGCTGTGTTTATCCTCAAACACAAACACTTTCCATGAACGTGGAGATCAACCCACTGCAGAGCACCGTGCACAAGGTCCTCCCCAGTGGTGAAGGGGTTTATCAGGTGCGGATGGTCCCGTATGTGGATGAAGAGTTCACTCAGCCCTTCACTGGTAGAGTGGATGCAGAGCTGGACCAGGAGATGCATGTGGAGGTTGGTGTTGAGGGGGTCGACAGCCGCCAGTTTGCCCTGGTGATGGACACGTGTTGGGCTACACCTGTGAATGACCCTGATTACAGTCTCCGCTGG
```

* Trinity groups its transcripts into clusters based upon shared sequence content
* These clusters are referenced as a gene, and are encoded within the Trinity fasta accession
  * The fasta accession encodes Trinity gene and isoform data

Lets examine the second accession, `TRINITY_DN30_c0_g2_i5`

`TRINITY_DN30_c0_g2_i5` points to Trinity read cluster `TRINITY_DN30_c0`, gene `g2`, and isoform `i5`

Any run of Trinity is going to involve a large amount of clusters of reads, with each one being assembled separately

* Because gene numberings are unique within any selected processed read cluster, the gene identifier needs to be thought of as an aggregate of both the read cluster and corresponding gene identifier
* In this example, `TRINITY_DN30_c0_g2`

In short, gene id: `TRINITY_DN30_c0_g2` encoding isoform id: `TRINITY_DN30_c0_g2_i5`

Path information is also stored on the same line as the accession, in the form of `path=[0:0-149 2:150-278, etc]`

* This indicates the path that was traversed in the Trinity compressed de Bruijn graph to build that transcript
* In this example, node `0` corresponds to sequence range `0-149` of the transcript, node `2` corresponds to sequence range `150-278`, and so on
* These node id's are only unique in the context of a chosen Trinity gene identifier
  * they can't be compared among isoforms to identify unique and shared sequences of each isoform of a selected gene

#### 6.2 Trinity.fasta.gene_trans_map

* Mapping between the a Trinity gene id, and it's corresponding transcript accession
* Useful for downstream analysis, such as porting abundance estimates to an expression matrix, using a built in Trinity tool

#### 6.3 Trinity.timing

* Includes details about the Trinity run, such as parameters used, input file sizes, unique KMERs, and runtime

## Contact
If you have questions about the information in this worksheet, please contact:

```
Nathaniel Maki
Bioinformatics Training Specialist
MDI Biological Laboratory
nmaki[at]mdibl.org
```