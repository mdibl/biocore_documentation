---
title: Assembly Exploration Worksheet
author: Nathaniel Maki
organization: MDIBL Computational Core
date: March 1st, 2021
---

# Assembly Exploration Worksheet

## Learning Objectives

* Improve skills in filesystem navigation and file modification through the use of the CLI and nano
* Through the Bowdoin SGE Compute Cluster, use a Transrate script in conjunction with Commander to generate a some statistical output on your assembled transcriptome
* Understand the options contained within the Transrate script, and how they can impact your resulting analysis

### Step 0: Connecting to the Cluster

This step has been covered in a previous lecture, and is required to proceed with this worksheet

In short, ensure that you've connected to the Bowdoin VPN, have logged into Moosehead, and that your terminal is displaying the following

<img src="./assembly_worksheet_img/img1.png" width="800">

### Step 1: Navigating through the Cluster ( where are all the things :thinking: )

The path to your specific User directory is `/mnt/courses/biol2566/people/` followed by your username

This User directory will be automatically populated with `Analysis`, `Data`, etc by Commander, and scripts you launch will dump their output here, in a predictable, findable, and structured format

We are also going to be editing some template files, to point towards your specific directory structure

Those template files can be found at `/mnt/courses/biol2566/software/compbio_commander/paramfile_templates`

### Step 2: Copying Template files to qsub directory

First, create a directory called `qsub` in your home directory (reached by typing `cd ~`)

* `mkdir qsub`
* `cd` into `qsub`

Copy the template json files we've provided from the above path to the `qsub` directory

* `cp /mnt/courses/biol2566/software/compbio_commander/paramfile_templates/*.json ./`

### Step 3: Editing the Transrate json file

First, we're going to want to give the template file a more unique name

Using the `mv` command, change the name of the `bowdoin_transrate_template.json` file to `"username"_transrate_template.json`

* `mv bowdoin_transrate_template.json` `nmaki_transrate_template.json`

Now open the named `transrate_template.json` in `nano`

The default file will look like this:

```
{
	"job_details": {
		"job_name": "YOUR_USERNAME_transrate_test"
	},
	"experiment_details": {
		"pi": "Bowdoin",
		"experiment_name": "jcoffman_001.reduced",
		"analysis_id": "0123456789",
		"sample_path": "/mnt/courses/biol2566/data",
		"analysis_path": "/mnt/courses/biol2566/people/YOUR_USERNAME/analysis",
		"workdir": null,
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
		"# *** ENVIRONMENT VARIABLES TO BE USED AT QSUB-SCRIPT LEVEL ONLY *** #",
		"# *** DO NOT TRY TO REFERENCE THESE VARIABLES IN THE TRINITY COMMAND *** #",
		"",
		"# Top level course space",
		"classdirectory='/mnt/courses/biol2566'",
		""
	],
	"commands": [
		{
			"command": "transrate",
			"batch": false,
			"tasks": 1,
			"cpus": 3,
			"memory": 128,
			"singularity_path": "$classdirectory/software/sif",
			"singularity_image": "transrate_v1_0_3.sif",
			"work_dir": null,
			"volumes": [
				{
					"host_path":"$classdirectory",
					"container_path":"/compbio"
				}
			],
			"options": [
				"--assembly /compbio/people/YOUR_USERNAME/analysis/Bowdoin/jcoffman_001.reduced/0123456789/Trinity/Trinity.fasta",
				"--output /compbio/people/YOUR_USERNAME/analysis/Bowdoin/jcoffman_001.reduced/0123456789/transrate/",
				"--threads 16"
			],
			"arguments":null
		}
	]
}
```

You'll need to replace anything in ALL-CAPS with details relative to your username and options that we'll define below

* Ignore the `misc_preamble`, that does not need to be modified

Lets edit the file together, moving through it block by block

The block identifier will be denoted in **bold**, with expected output following below that
#### 3.1: job_details

* Update the "job_name" entry with a new id (can be something as simple as nmaki_transrate_test)

**Expected**

```
"job_details": {
		"job_name": "nmaki_transrate_test"
```

#### 3.2: experiment_details

* Update the "analysis_path" entry with your username where specified

**Expected**

```
"experiment_details": {
		"pi": "Bowdoin",
		"experiment_name": "jcoffman_001.reduced",
		"analysis_id": "0123456789",
		"sample_path": "/mnt/courses/biol2566/data",
		"analysis_path": "/mnt/courses/biol2566/people/nmaki/analysis",
		"workdir": null,
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
* Update the "--assembly" option with the details for "pi", "experiment_name" and "analysis_id"
* Update the "--output" option with the details for "pi", "experiment_name" and "analysis_id"

**Expected**

```
"commands": [
		{
			"command": "transrate",
			"batch": false,
			"tasks": 1,
			"cpus": 3,
			"memory": 128,
			"singularity_path": "$classdirectory/software/sif",
			"singularity_image": "transrate_v1_0_3.sif",
			"work_dir": null,
			"volumes": [
				{
					"host_path":"$classdirectory",
					"container_path":"/compbio"
				}
			],
			"options": [
				"--assembly /compbio/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/Trinity/Trinity.fasta",
				"--output /compbio/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/transrate/",
				"--threads 16"
			],
			"arguments":null
		}
	]
```

### Step 4: Executing Commander on edited Transrate json file

Once we've made all the necessary modification, and our script closely resembles the example above, save the changes with `ctrl + o` and then exit out of `nano` using `ctrl + x`

Next, we want to feed the json file into Commander, which will generate a bash script and allow us to run the job on our compute cluster

The command you'll want to run is as follow:

* `/mnt/courses/biol2566/software/compbio_commander/commander --sge --preflight nmaki_transrate_template.json`

If you execute an `ls` in your `qsub` directory, you'll see that we now have another file, one with a `.sh` suffix

### Step 5: Launching the Transrate shell script through qsub

To launch your shell script, simply type the following into the command line

* `qsub nmaki_transrate_test.sh`

To check on a currently submitted job, you can use

* `qstat -u "username"`

### Step 6: Examining output

Your output will be deposited in two regions:

Log file with many of the metrics we want to look at will be placed in your `qsub` directory

* `/home/username/qsub`
  * `nmaki_transrate_test.sh.o***`

The core stats that make up that file will be located here in the following directory

* `/mnt/courses/biol2566/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/transrate/`

The names of the directories that have been auto-generated rely upon the parameters given in the json script 

Some of these folders may differ depending upon what you called them

Assuming that everything has ran properly, running an `ls` in the `transrate` directory should yield two results

* assemblies.csv
* /Trinity/ directory
  * contigs.csv

#### Step 6.1 Contig metrics

* Use the `cat` command on your `nmaki_transrate_test.sh.o***` to view the contents of the file

**Expected**

```
[ INFO] 2021-03-08 19:42:00 : Loading assembly: /compbio/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/Trinity/Trinity.fasta
[ INFO] 2021-03-08 19:42:00 : Analysing assembly: /compbio/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/Trinity/Trinity.fasta
[ INFO] 2021-03-08 19:42:00 : Results will be saved in /compbio/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/transrate/Trinity
[ INFO] 2021-03-08 19:42:00 : Calculating contig metrics...
[ INFO] 2021-03-08 19:42:00 : Contig metrics:
[ INFO] 2021-03-08 19:42:00 : -----------------------------------
[ INFO] 2021-03-08 19:42:00 : n seqs                          195
[ INFO] 2021-03-08 19:42:00 : smallest                        201
[ INFO] 2021-03-08 19:42:00 : largest                        5258
[ INFO] 2021-03-08 19:42:00 : n bases                      201102
[ INFO] 2021-03-08 19:42:00 : mean len                    1031.29
[ INFO] 2021-03-08 19:42:00 : n under 200                       0
[ INFO] 2021-03-08 19:42:00 : n over 1k                        70
[ INFO] 2021-03-08 19:42:00 : n over 10k                        0
[ INFO] 2021-03-08 19:42:00 : n with orf                       86
[ INFO] 2021-03-08 19:42:00 : mean orf percent              70.85
[ INFO] 2021-03-08 19:42:00 : n90                             352
[ INFO] 2021-03-08 19:42:00 : n70                            1272
[ INFO] 2021-03-08 19:42:00 : n50                            2010
[ INFO] 2021-03-08 19:42:00 : n30                            2632
[ INFO] 2021-03-08 19:42:00 : n10                            4289
[ INFO] 2021-03-08 19:42:00 : gc                             0.45
[ INFO] 2021-03-08 19:42:00 : bases n                           0
[ INFO] 2021-03-08 19:42:00 : proportion n                    0.0
[ INFO] 2021-03-08 19:42:00 : Contig metrics done in 0 seconds
[ INFO] 2021-03-08 19:42:00 : No reads provided, skipping read diagnostics
[ INFO] 2021-03-08 19:42:00 : No reference provided, skipping comparative diagnostics
[ INFO] 2021-03-08 19:42:00 : Writing contig metrics for each contig to /compbio/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/transrate/Trinity/contigs.csv
[ INFO] 2021-03-08 19:42:01 : Writing analysis results to assemblies.csv
```

These metrics are based on just an analysis of the set of contigs themselves, and only really useful as a quick-and-dirty way of screening for major issues in your assembly

They can be informative, but aren't great for judging over assembly quality (due to not knowing what the "optimum" is)

Only extremes can reliably be recognized, either a very small (<5000) or very large (>100,000) number of contigs is not biologically probable for most organisms

You'll need to leverage your biological knowledge to choose which values you find acceptable

Obviously for this test dataset, we can't really draw any meaningful conclusions

#### Step 6.2 Assembly score

* Use the `cat` command on the `assemblies.csv` file found in your user-specific `transrate` directory

**Expected**

```
assembly,n_seqs,smallest,largest,n_bases,mean_len,n_under_200,n_over_1k,n_over_10k,n_with_orf,mean_orf_percent,n90,n70,n50,n30,n10,gc,bases_n,proportion_n,score,optimal_score,cutoff,weighted
Trinity.fasta,195,201,5258,201102,1031.29231,0,70,0,86,70.84614,352,1272,2010,2632,4289,0.44746,0,0.0,NA,NA,NA,NA
```

The `assemblies.csv` file echoes a lot of what was found in the log file, but what we're most interested in is the `score` of our assembly

* How confident we can be in what we assembled
* How complete the assembly is

The score ranges from 0 to 1, with a higher score increasing the likelihood that you have an assembly that is biologically accurate

#### Step 6.3 Read mapping metrics

* Generated by aligning the reads used in the assembly to the assembled transcriptome

The most useful metric, due to the wealth of organism-specific information that the reads contain

This data can be used to evaluate confidence in every base and contig present in the assembly

Upon including the `--left` and `--right` input options, Transrate will

* Map provided reads to the assembly
* Infer most likely contig of origin for any reads that multi-map with `Salmon`
* Inspect resulting alignments with `transrate-tools`, using them for evaluation on every contig in the transcriptome

Able to detect "good" and "bad" mappings

* Good mappings are those that align in such a way that is consistent with the contig being perfectly composed
  * Both members of pair are aligned
  * In proper orientation
  * On same contig
  * Without overlapping either end of contig

* Bad mappings are those that fail any of the above conditions

## Contact
If you have questions about the information in this worksheet, please contact:

```
Nathaniel Maki
Bioinformatics Training Specialist
MDI Biological Laboratory
nmaki[at]mdibl.org
```