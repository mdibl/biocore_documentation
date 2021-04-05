---
title: Cutting Class Worksheet
author: Nathaniel Maki
organization: MDIBL Computational Core
date: March 24th, 2021
---

# Cutting Class Worksheet

## Learning Objectives

* Become familiar with the Gene Search on the CC site, and the Sequence Similarity Search
* Gain an understanding of the query results

### Search Genes

The Search Genes tool lets you search for a Gene by name, or putative (known/assumed) function

For this, we're interested in a gene that's in any of the four species of Planarian, so we can keep `Species` as Any

2 ways to get gene of interest in this organism


* `Search by Name` lets you plug in the unique identifier of the sequence, or upload a text file containing a nucleotide sequence(s)
  * Useful if you've got multiple sequences you want to query against
* What if you already know a fruit fly, human, or planarian gene name or function, and you'd like to locate a similar analogue in the four species listed above?
  * You can use the `Search by Putative Function`
    * Searching for descriptions of the proteins that were matched by the transcripts putative proteins
    * We assign functionality in novel organism by trying our best to align new protein to existing protein to get function

Lets search for the `FoxA` gene, which is evolutionarily conserved, being involved in the development of the digestive system in a large swath of mammals. In planaria, it plays a role in regeneration

You'll get a whole host of summarized information in a `record` table

* Record number
* Gene name, linking out to gene page
* Length of nucleotide sequence
* Name of homologous sequences found in S. mediterranea
* Name of homologous sequences found in H. Sapiens
* Name of homologous sequences found in D. melanogaster
* Description of sequence in `Uniprot` (Universal Protein Resource)
* Uniprot E-value (denotes how likely it is that a sequence is homologous to another)
  * Number of `hits` one will get by querying a database of some size, decreasing as match increases

Selecting a gene will take you to the Gene page

* Overview has a summary of sequence, with name, unique name, type of sequence, organism, and sequence length
* Analyses lists the analysis that was performed to get the requisite data for this sequence
* Under Analyses you've got all of the results from the various type of analysis conducted, from generation of a transcriptome assembly (set of all RNA transcriptome in an organism / set of cells) to the results of BLASTXing Girardia Sp. against Human, to BLASTXing against the protein database Swissprot

Let's take a look at the Transcriptome!

* Analysis overview is very similar to a GEO Series (experiment record)
* Includes the exact Trinity software package that was used to build the Transcriptome Assembly (set of all RNA transcripts) of the organism
  * Used seqclean QC tool to "spruce" up the output (generally though, QC is done before Assembly)
  * Wanting to "map meaning" to the constructed assembly, created a set of non-redundant likely protein coding sequences using Transdecoder, and then reducing the resulting set down to its longest sequence by clustering with cd-hit, selecting the longest sequence from each cluster to be the representative seq

#### Homology

Contains top sequence results from a number of BLAST runs on this specific sequence against database sequences from human, fruit fly, planarian, and Swissprot (protein db)

* Each table has the match sequence name, as well as the E-value (number of times a match is expected in database of n size, lower = better match), percent identity (how similar query seq is to target seq, higher = better match), and description
* Why gap in BLASTX against Schmidtea mediterranea?
  * potential mismatch, no sequence aligning at that regions (creating a gap)

#### Sequences

Contains mRNA, coding (CDS) and protein sequences (we're going to blastn/blastx these)

### Sequence Similarity Search

Searching for sequences similar to one we've already selected

Are you working with a nucleotide or protein sequence?

If nucleotide, `blastn` or `blastx`:

* blastn can be used when checking a nucleotide sequence between the same species (nucleotide to nucleotide db)
* blastx is utilized when searching a nucleotide sequence from a species that differs from the species of the comparison protein sequence (nucleotide to protein db)
  * First, the query nucleotide is processed through a translation layer, to the amino acid sequences in every of the 6 reading frames
  * Then, that translated sequence (now protein) is checked against protein db

If protein, `tblastn` or `blastp`

* tblastn when you want to check a protein sequence against a nucleotide db
  * In this case, the entire nucleotide db is translated to protein (AA) sequence and then compared against
* blastp to query a protein sequence against a protein db


