---
title: Assembly Exploration Worksheet
author: Nathaniel Maki
organization: MDIBL Computational Core
date: March 1st, 2021
---

# Assembly Exploration Worksheet

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

Once you've migrated into your directory, you should see folder such as `analysis`, `data`, etc

These are the folders that you'll be working with for the worksheet, and duration of the course

We are also going to be editing some template files, to point towards your specific directory structure

Those template files can be found at `/mnt/courses/biol2566/software/compbio_commander/paramfile_templates`

### Step 2: Copying Template files to User directory