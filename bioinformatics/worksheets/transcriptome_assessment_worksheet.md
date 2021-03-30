---
title: Introduction to Transcriptome Assessment and Analysis
author: Nathaniel Maki
organization: MDIBL Computational Core
date: March 20th, 2021
---

# Introduction to Transcriptome Assessment and Analysis

## Learning Objectives

* Become familiar with some of the exploratory post-assembly assessment and annotation processes
* Acquire a fundamental working knowledge of the tools used for the above processes, their necessity, and how to interpret their output
* Gain hands-on experience by applying your new-found skills to your own assembly

### Step 0: Acquiring Files

Before we can begin this lesson, we need to copy down a suite of template files from `paramfile_templates` down to the `qsub` folder we created (since we need all the files in that dir, you can use the `cp *.json` command to bring them all down):

* `/mnt/courses/biol2566/software/compbio_commander/paramfile_templates`
  * `bowdoin_cdhit_template.json`
  * `bowdoin_rnaspades_template.json`
  * `bowdoin_soapdenovo_127mer_template.json`
  * `bowdoin_soapdenovo_31mer_template.json`
  * `bowdoin_transdecoder_longorfs_template.json`
  * `bowdoin_transdecoder_predict_template.json`
  * `bowdoin_transrate_template.json`

Once those files are in your qsub directory, we'll move on to the first component, Assessment

**Note for the below Steps**

While these are described in steps, the order in which we do 1 and 2 can be reversed

### Step 1: Assessment

#### Transrate

Written by the developers of Trinity, Transrate is a piece of software for *de-novo* transcriptome assembly quality analysis

It's capable of providing detailed reports, and examines your assembly, comparing it to experimental evidence (the initial sequencing reads), writing out quality scores for assemblies and contigs

Also has the capability to merge together multiple assemblies from varied assemblers, and conduct scoring on the resulting amalgamation

Overall, it analyzes an assembly in three ways

* Inspection of contig sequences (what the transcriptome assembly is composed of)
* Mapping Reads to contigs, and inspecting how well they align (how closely does your resulting assembly match the data that was used to generate it)
* Aligning the contigs against proteins or transcripts from related species, inspecting alignments

The most *useful* metrics are the ones based upon read mapping

* Transrate Assembly score
* Optimized Assembly score
* Individual contig scores

#### Step 1.1: Editing `bowdoin_transrate_template.json`

For this specific run, just make the appropriate changes where CAPS are present

#### Step 1.2: Launching `bowdoin_transrate_template.json` through Commander

The process here is identical to running Trinity:

* `/mnt/courses/biol2566/software/compbio_commander/commander --sge --preflight bowdoin_transrate_template.json`
* Then `qsub` the generated `transrate.sh` file

#### Step 1.3: Examining Output

* Looking at the *.o##### log file

##### Contig Metrics

* Measured based upon analyzing the set of contigs themselves
* Useful as a quick way of detecting massive issues with your assembly, namely very small or very large numbers of contigs
  * those that are biologically improbable

```
Contig metrics:
-----------------------------------
n seqs                          188 number of contigs in assembly
smallest                        201 size of smallest contig
largest                        5258 size of largest contig
n bases                      194198 number of bases included in assembly
mean len                    1032.97 mean length of the contig
n under 200                       0 number of contigs < 200 bases
n over 1k                        67 number of contigs > 1K bases
n over 10k                        0 number of contigs > 10K bases
n with orf                       79 number of contigs that had an ORF
mean orf percent              69.84 for contigs with ORF, mean % of the contig covered by ORF
n90                             351 largest contig size at which at least X% of bases are contained in contigs at least this length
n70                            1289 *
n50                            2010 *
n30                            2711 *
n10                            4734 *
gc                             0.45 % of bases that are G or C
bases n                           0 number of N bases
proportion n                    0.0 proportion of bases that are N
Contig metrics done in 0 seconds
Calculating read diagnostics...
```

##### Read Mapping Metrics

* Based upon aligning the reads used in assembly to the assembled contigs
* The mapped reads contain a large amount of information specific to the organism that was sequenced, and this info can be leveraged to evaluate the confidence in each base and contig in your resulting assembly (you're essentially mapping the source material on to your transcriptome, looking to see how much was preserved/properly reconstructed)

With the `--left` and `--right` option enabled, transrate:

* Maps the provided reads to the assembly using SNAP
* Infers the most likely contig of origin for any multi-mapping reads with Salmon
* Inspects the resulting alignment with transrate-tools and evaluates each contig in the assembly

```
Read mapping metrics:
-----------------------------------
fragments                    535815 number of read pairs provided
fragments mapped             396882 total number of read pairs mapping
p fragments mapped             0.74 proportion of provided read pairs that mapped successfully
good mappings                189659 number of read pairs mapping in a way indicating a good assembly
p good mapping                 0.35 proportion of the above
bad mappings                 207223 number of read pairs mapping in a way indicating a poor assembly
potential bridges                41 number of potential links between contigs that are supported by the reads
bases uncovered               12027 number of bases that aren't covered by any reads
p bases uncovered              0.06 proportion of the above
contigs uncovbase               143 number of contigs that contain at least one base with no read coverage
p contigs uncovbase            0.76 proportion of the above
contigs uncovered                40 number of contigs that have a mean per-base read coverage of < 1
p contigs uncovered            0.21 proportion of the above
contigs lowcovered               82 number of contigs that have a mean per-base read coverage of < 10
p contigs lowcovered           0.44 proportion of the above
contigs segmented                 8 number of contigs that have a >=50% estimated chance of being segmented
p contigs segmented            0.04 proportion of the above
Read metrics done in 10 seconds
No reference provided, skipping comparative diagnostics
```

What makes a "good" mapping?

* Both member of the read pair are aligned
* in proper orientation
* on the same contig
* without overlapping either end of the contig

Your mapping is "poor" if any of the above metrics aren't met

Running in the above produces:

##### Transrate Score

The most useful metric, measure quality of the assembly *without* using a reference

* Score is generated for the entire assembly, and for each contig, with the scoring process using the reads that were used to build the assembly as evidence

```
TRANSRATE ASSEMBLY SCORE     0.0573
-----------------------------------
TRANSRATE OPTIMAL SCORE      0.1539
TRANSRATE OPTIMAL CUTOFF     0.3685
good contigs                     81
p good contigs                 0.43
```

The core stats that make up that file will be located here in the following directory

* `/mnt/courses/biol2566/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789/transrate/`

The names of the directories that have been auto-generated rely upon the parameters given in the json script 

Some of these folders may differ depending upon what you called them

Assuming that everything has ran properly, running an `ls` in the `transrate` directory should yield two results

* assemblies.csv
* /Trinity/ directory
  * contigs.csv

### Step 2: Reduction

#### CD-HIT-EST

A program (from the CD-HIT suite) that is primarily used to cluster and compare protein and/or nucleotide sequences, massively reducing the amount of computational cycles required for downstream tasks

Clusters nucleotides sequences that match some similarity threshold, building a fasta file of representative sequences (reduced) and a text file of the clusters

Why is this tool useful?

What risks might it pose?

#### Step 2.1: Editing `bowdoin_cdhit_template.json`

For this specific run, just make the appropriate changes where CAPS are present

#### Step 2.2: Launching `bowdoin_cdhit_template.json` through Commander

* Same as for the Transrate script

#### Step 2.3: Examining Output

Located here:

* `/mnt/courses/biol2566/people/nmaki/analysis/Bowdoin/jcoffman_001.reduced/0123456789`

Generates two files:

* jcoffman_001.reduced (reduced transcript file)
* jcoffman_001.reduced.clstr (list of clusters found)

```
>Cluster 0
0	5258aa, >TRINITY_DN35_c0_g1_... *
>Cluster 1
0	4734aa, >TRINITY_DN102_c0_g1... *
>Cluster 2
0	3306aa, >TRINITY_DN27_c0_g2_... at 99.64%
1	3306aa, >TRINITY_DN27_c0_g2_... at 99.18%
2	3749aa, >TRINITY_DN27_c0_g2_... *
3	3749aa, >TRINITY_DN27_c0_g2_... at 99.65%
4	247aa, >TRINITY_DN76_c0_g1_... at 94.33%
>Cluster 3
0	1953aa, >TRINITY_DN47_c0_g1_... at 97.54%
1	3732aa, >TRINITY_DN47_c0_g1_... *
>Cluster 4
0	3661aa, >TRINITY_DN2_c0_g3_i... *
>Cluster 5
0	3218aa, >TRINITY_DN64_c0_g1_... *
>Cluster 6
0	3212aa, >TRINITY_DN17_c0_g2_... *
>Cluster 7
0	2989aa, >TRINITY_DN13_c0_g2_... *
>Cluster 8
0	2812aa, >TRINITY_DN4_c0_g1_i... *
>Cluster 9
0	2803aa, >TRINITY_DN30_c0_g1_... *
>Cluster 10
0	2756aa, >TRINITY_DN13_c0_g1_... *
```

The tool has two modes, global and local

* global computes seq identify from the number of identical bases divided by the length of a chosen sorter sequence
* local computes it as the number identical bases divided by the length of the alignment

Sequence identity needs to exceed a sequence identity threshold to relate that two sequences are part of the same cluster

##### Questions?

How to tell what the "representative sequence" is for multiple accessions in a cluster?

"*" characters following sequences in a cluster (falls below threshold)

### Step 3: Exploration

#### TransDecoder

Identifies candidate coding regions within transcripts

Based upon following criteria:

* minimum length ORF found in transcript
* log-likelihood score being > 0 (explain?)
* above coding score is greatest when ORF is scored in the 1st reading frame in comparison to scores in the other 2 forward reading frames
* if candidate ORF is found to be fully encapsulated by the coordinates of another candidate ORF, longer one is reported
  * Single transcripts is able to report multiple ORFS (chimeras, etc)

First we need to extract the ORFS from our transcript assembly

* TransDecoder defaults to identifying ORFs that are at least 100 AA long (can be modified to be lower)
  * lowering this can increase the rate of false positive ORF predictions using shorter thresholds

```
longest_orfs.pep   : all ORFs meeting the minimum length criteria, regardless of coding potential.
longest_orfs.gff3  : positions of all ORFs as found in the target transcripts
longest_orfs.cds   : the nucleotide coding sequence for all detected ORFs

longest_orfs.cds.top_500_longest : the top 500 longest ORFs, used for training a Markov model for coding sequences.

hexamer.scores                   : log likelihood score for each k-mer  (coding/random)

longest_orfs.cds.scores               : the log likelihood sum scores for each ORF across each of the 6 reading frames
longest_orfs.cds.scores.selected      : the accessions of the ORFs that were selected based on the scoring criteria (described at top)
longest_orfs.cds.best_candidates.gff3 : the positions of the selected ORFs in transcripts
```

Also have the option to identify ORFs that have homology to known proteins through blastp queries

Once you've extracted your ORFS, you can predict likely coding regions using TransDecoder.Predict

* Final set of candidate coding regions have the flag '.transdecoder' and consist of extensions .pep, .cds, .gff3, and .bed

```
transcripts.fasta.transdecoder.pep : peptide sequences for the final candidate ORFs; all shorter candidates within longer ORFs were removed.
transcripts.fasta.transdecoder.cds  : nucleotide sequences for coding regions of the final candidate ORFs
transcripts.fasta.transdecoder.gff3 : positions within the target transcripts of the final selected ORFs
transcripts.fasta.transdecoder.bed  : bed-formatted file describing ORF positions, best for viewing using GenomeView or IGV.
```