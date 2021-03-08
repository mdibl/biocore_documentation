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
		"job_name": "ENTER_YOUR_JOBNAME_HERE"
	},
	"experiment_details": {
		"pi": "PI",
		"experiment_name": "EXPERIMENT_NAME",
		"analysis_id": "ANALYSIS_ID",
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
				"--assembly /compbio/people/YOUR_USERNAME/analysis/PI_NAME/EXPERIMENT_NAME/ANALYSIS_ID/Trinity/Trinity.fasta>",
				"--output /compbio/people/YOUR_USERNAME/analysis/PI_NAME/EXPERIMENT_NAME/ANALYSIS_ID/transrate/",
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

* Update the "pi" entry to "Bowdoin"
* Update the "experiment_name" entry to "jcoffman_001.reduced"
* Update the "analysis_id" entry to an id of your choosing (can be 0123456789)
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
				"--assembly /compbio/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/Trinity/Trinity.fasta>",
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

Your output will be deposited into your home directory (reachable through `cd ~`) in a folder named `transrate_results`

* `/home/nmaki/transrate_results`