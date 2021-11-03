# MINOTA 2021 Day 3 Script

## Guide

For tomorrow, here are two things that would be great if you could work on. Assume that we will have at least two transcriptomes built from the jcoffman_001.reduced data, one from trinity and one from rna_spades. Working with one or both of those, we are going to want to run it through (1) cd-hit-est by itself, (2) transdecoder by itself, (3) cd-hit-est followed by transdecoder, (4) cd-hit-est followed by transdecoder followed by cd-hit. If we have the time, it would be very much of interest to potentially concatenate the files together and then run the same analyses, under the assumption that each program will do an imperfect job, and joining their outputs and using the filtering tools here will come up with a better answer

In addition to this, we will probably also want to run transrate on some subset of this as well, using the input fastq files against the transcriptomes

--------

It would probably be best to start with a run through transrate first, including the starting data (which would be the trim_galore output). Then for comparison, you could use cd-hit-est on the data set and then run transrate on the resulting reduced data set

## Getting Started

First, let’s get ourselves logged back into our remote AWS machines.

* Today we’ll be covering refinement, clustering, protein prediction, and assessing the “completeness” of an assembled transcriptome
* `cd` into your `minota_work` directory
* run the following commands:
  * `cd_hit_est_singularity -x`
  * `cd_hit_singularity -x`
  * `transrate_pe_singularity -x`
  * `transdecoder_singularity -x`

## Transrate

The first program we're going to run our trinity transcriptome through is Transrate

WTransrate is a piece of software for *de-novo* transcriptome assembly quality analysis

It's capable of providing detailed reports, and examines your assembly - comparing it to experimental evidence (which are your initial sequencing reads), writing out quality scores for assemblies and generated contigs

It also has the capability to merge together multiple assemblies from varied assemblers, and conduct scoring on the resulting amalgamation

Overall, it analyzes an assembly in three ways

* Inspection of contig sequences (what the transcriptome assembly is composed of)
* Mapping Reads to contigs, and inspecting how well they align (how closely does your resulting assembly match the data that was used to generate it)
* Aligning the contigs against proteins or transcripts from related species, inspecting resulting alignments

The most *useful* metrics are the ones based upon read mapping

* Transrate Assembly score
* Optimized Assembly score
* Individual contig scores

### Editing Transrate config file

Now lets edit our generated Transrate config file using `nano`

* here is where it may be useful to split your `tmux` session
* this will allow you to query paths to your assembly/input data, while keeping your editor open in another pane

Once open in `nano`, point the *assembly* parameter to the location of your Trinity assembly (*Trinity.fasta*)

* `assembly=/home/minota/minota_work/trinity_out/Trinity.fasta`

Next are your right and left reads

* point towards the trimmed read files
* `left=/home/minota/minota_work/trim_galore_out/jcoffman_001.reduced_all_R1_val_1.fq.gz`
* `right=/home/minota/minota_work/trim_galore_out/jcoffman_001.reduced_all_R2_val_2.fq.gz`

And finally the name and location of your output directory

* `output=/home/minota/minota_work/transrate_out`

#### Examining Transrate Output

First, we want to look at the .log file

The core stats that make up that file will be located here in the following directory

* `/home/minota/minota_work/transrate_out`

The names of the directories that have been auto-generated rely upon the parameters given in the configuration file

Some of these folders may differ depending upon what you called them

Assuming that everything has ran properly, running an `ls` in the `transrate_out` directory should yield two results

* assemblies.csv
* /Trinity/ directory
  * contigs.csv

##### Transrate Score

The most useful metric, measure quality of the assembly *without* using a reference

* Score is generated for the entire assembly, and for each contig, with the scoring process using the reads that were used to build the assembly as evidence
* Provides you with the capability to compare multiple assemblies based off of the same reads
  * an increase in your score most likely corresponds to an assembly with higher biological accuracy
  * captures how confident you can be in what was assembled, and how "complete" your transcriptome is
  * Scales from 0 to 1.0 (maximum)

Expression-weighted quality score

* Score for each contig is multiplied by its relative expression before being included in assembly score (low weight assigned to poorly expressed contigs)
* More generous to assemblies with poorly assembled contigs of low expression
  * stored in the `assemblies.csv` file

What we're most interested in is the `score` of our assembly

* How confident we can be in what we assembled
* How complete the assembly is

The score ranges from 0 to 1, with a higher score increasing the likelihood that you have an assembly that is biologically accurate

```
TRANSRATE ASSEMBLY SCORE     0.0573
-----------------------------------
TRANSRATE OPTIMAL SCORE      0.1539
TRANSRATE OPTIMAL CUTOFF     0.3685
good contigs                     81
p good contigs                 0.43
```

* Use the `cat` command on the `assemblies.csv` file found in your user-specific `transrate_out` directory

**Expected**

```
assembly,n_seqs,smallest,largest,n_bases,mean_len,n_under_200,n_over_1k,n_over_10k,n_with_orf,mean_orf_percent,n90,n70,n50,n30,n10,gc,bases_n,proportion_n,fragments,fragments_mapped,p_fragments_mapped,good_mappings,p_good_mapping,bad_mappings,potential_bridges,bases_uncovered,p_bases_uncovered,contigs_uncovbase,p_contigs_uncovbase,contigs_uncovered,p_contigs_uncovered,contigs_lowcovered,p_contigs_lowcovered,contigs_segmented,p_contigs_segmented,score,optimal_score,cutoff,weighted
/home/minota/minota_work/trinity_out/Trinity.fasta,133,202,5258,185932,1397.98496,0,67,0,77,71.56003,603,1530,2272,3176,4734,0.4471,0,0.0,535728,426019,0.79522,187828,0.3506,238191,40,3010,0.01619,96,0.7218,1,0.00752,1,0.00752,7,0.05263,0.08865,0.14176,0.31556,925.65749
```

##### Contig Score

Stored in the `contigs.csv` file, each contig gets assigned a score by measuring how well it's supported by read evidence

Four components to the score

* Measure of correct base call
* Measure of whether each base is part of the transcript
* Probability that the contig is derived from a single transcript (and not pieces of two or more)
* Probability that the contig is structurally complete and accurate

##### Optimized Assembly Score

Using contig scores, bad contigs are filtered out from your assembly, leaving only those that are well assembled

* Done automatically, by learning contig score cutoff that maximizes assembly score
* Good contigs determined by the above optimization are in the good.*.fa file
* Bad contigs are in the bad.*.fa file

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

With the `--left` and `--right` option enabled, Transrate:

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

## TransDecoder 

Identifies candidate protein coding regions within transcripts, allowing you to stage sequences in blastp/blastx for functional discovery

Based upon following criteria:

* minimum length ORF found in transcript
* log-likelihood score being > 0 (explain?)
* above coding score is greatest when ORF is scored in the 1st reading frame in comparison to scores in the other 2 forward reading frames
* if candidate ORF is found to be fully encapsulated by the coordinates of another candidate ORF, longer one is reported
  * Single transcripts is able to report multiple ORFS (chimeras, etc)

### Editing TransDecoder Config file

Point the `transcript_file` entry to your transcriptome

* `transcript_file=/home/minota/minota_work/trinity_out/Trinity.fasta`
* `output_dir=/home/minota/minota_work/transdecoder_out`

### TransDecoder LongORFS

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

### TransDecoder Predict

Once you've extracted your ORFS, you can predict likely coding regions using TransDecoder.Predict

* Normally, final set of candidate coding regions have the flag '.transdecoder' and consist of extensions .pep, .cds, .gff3, and .bed

```
transcripts.fasta.transdecoder.pep : peptide sequences for the final candidate ORFs; all shorter candidates within longer ORFs were removed.
transcripts.fasta.transdecoder.cds  : nucleotide sequences for coding regions of the final candidate ORFs
transcripts.fasta.transdecoder.gff3 : positions within the target transcripts of the final selected ORFs
transcripts.fasta.transdecoder.bed  : bed-formatted file describing ORF positions, best for viewing using GenomeView or IGV.
```

## CD-HIT-EST

The next tool we'll work with is CD-HIT-EST

A program (from the CD-HIT suite) that is primarily used to cluster and compare nucleotide sequences, massively reducing the amount of computational cycles required for downstream tasks

Clusters nucleotides sequences that match some similarity threshold, building a fasta file of representative sequences (reducing redundancy) and a text file of the clusters

Before starting to edit the config file, create a new directory called `cd_hit_est_out` under `minota_work`

### Editing CD-HIT-EST config file

Once open in `nano`, point the *fasta* parameter to the location of your Trinity assembly (*Trinity.fasta*)

* `fasta=/home/minota/minota_work/trinity_out/Trinity.fasta`

The location and name of your output files

* `output=/home/minota/minota_work/cd_hit_est_out/jcoffman_001.reduced`

Number of cores

* 4

And amount of memory

* 32000

Execute with: `cd_hit_est_singularity -p cd_hit_est_parameter_template.txt`

#### Examining CD-HIT-EST output

Next lets `cd` into our new directory and examine the contents

Our script generates two files:

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
```

The tool has two modes, global and local

* global computes seq identify from the number of identical bases divided by the length of a chosen sorter sequence
* local computes it as the number identical bases divided by the length of the alignment

Sequence identity needs to exceed a sequence identity threshold to relate that two sequences are part of the same cluster

Used as a reduction technique, though you run the risk of merging together biologically interesting but similar sequences

* Upshot is drop potentially redundant isoforms that would impact the quality of your assembly

### Re-run Transrate on reduced dataset

To examine how the quality of our transcriptome has been improved by clustering, lets execute transrate on our CD-HIT_EST output

Inside of the `cd_hit_est_out` directory, copy down your transrate config file

* update your `assembly` path to point to your cd_hit_est output: `/home/minota/minota_work/cd_hit_est_out/jcoffman_001.reduced`
* add `cd_hit_est_out` to your `output` path

Run, and now lets compare the two reports!

## CD-HIT

CD-HIT clusters proteins that meet some similarity threshold, usually a sequence identity
Each cluster has a representative sequence, with the input being a protein dataset in fasta format
It outputs a fasta file of representative sequences and a text file of list of clusters

Before starting to edit the config file, create a new directory called `cd_hit_out` under `minota_work`

* Once open in `nano`, point the *fasta* parameter to the location of your TransDecoder predicted protein output (*Trinity.fasta.transdecoder.pep*)
* `fasta_file=/home/minota/minota_work/transdecoder_out/Trinity.fasta.transdecoder.pep`
* `output_file=/home/minota/minota_work/cd_hit_out/jcoffman_001.reduced`
* `num_threads=4`
* `memory_limit=32000`

### Examining CD-HIT Output

```
>Cluster 0
0       1700aa, >TRINITY_DN50_c0_g1_... *
>Cluster 1
0       1338aa, >TRINITY_DN14_c0_g1_... at 99.70%
1       233aa, >TRINITY_DN14_c0_g1_... at 99.14%
2       1620aa, >TRINITY_DN14_c0_g1_... *
3       1338aa, >TRINITY_DN14_c0_g1_... at 99.33%
4       1338aa, >TRINITY_DN14_c0_g1_... at 99.63%
5       1620aa, >TRINITY_DN14_c0_g1_... at 99.81%
>Cluster 2
0       1108aa, >TRINITY_DN0_c0_g1_i... at 97.20%
1       1122aa, >TRINITY_DN0_c0_g1_i... *
2       153aa, >TRINITY_DN0_c0_g1_i... at 90.20%
3       196aa, >TRINITY_DN0_c0_g1_i... at 96.43%
4       940aa, >TRINITY_DN0_c0_g1_i... at 98.83%
5       486aa, >TRINITY_DN0_c0_g1_i... at 95.68%
```