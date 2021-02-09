---
title: Introduction to Ensembl
author: "Nathaniel Maki"
organization: MDIBL Computational Core
date: "January 24th"
---

# Introduction to Ensembl

## Summary

* Ensembl is a genome browser, acting as a vast repository of reference genomes and annotations for a wide range of organisms, including Human, Mouse, C. Elegans, and Zebrafish
* Mostly dedicated to model organisms, but does contain resources for a number of non-model species
* Primarily focused on vertebrates, Ensembl Genomes extends across to non-vertebrates, and includes Plants, Fungi, and Bacteria

Ensembl annotates a large swath of data onto its genome assemblies, first type is Gene Models(builds)

## Gene Models

Comprised of: 

International Nucleotide Sequence databases (ENA, GenBank, DDBJ)
* cDNAs
* ESTs
* RNAseq

NCBI RefSeq
* Manually annotated proteins and MRNAs

Protein Sequence databases
* Swiss-Prot

Sequences from the above resources are aligned to the genome, transcripts clustered from alignments based on overlapping coding sequences

Forms Ensembl genes (automated genome annotation pipeline)

Ensembl genomes can either be automatically or manually annotated (HAVANA for manual)
* Set of genes is known as the Gencode geneset

In addition to gene annotation, other data types are added to genome, including variation data, comparative genomics, and regulatory features (which we'll touch on later)

## Querying

Choosing human genome build, and search for `tp53`

* links on the left of the page show specific information related to the TP53 gene

### Summary

* Gene has 27 transcripts annotated, 312 orthologues, 2 paralogues
* `Show transcript table` gives us detailed information regarding the Gene and it's associated transcripts
  * Transcript ID
  * Biotype
  * CCDS (Consensus Coding DNA seq set)
  * Uniprot Match - Link to Protein transcript entry

#### Gene Track

* Blue bar = Contigs (sequence of overlapping reads)
  * Transcripts above contig are on the forward strand, below it they're on the reverse
  * Boxes are exons, lines which connect them are the introns
    * Filled in boxes contain coding sequence, unfilled represent untranslated regions
    * Red = Ensembl Protein coding (annotated by Ensembl automated)
    * Gold = merged Ensembl/Havana (annotated by Ensembl automated + Havana manual annotation)
    * Blue = Processed Transcript
* Regulation
  * Dark Salmon = Promoter
  * Light Salmon = Promoter Flank
  * Pink = Transcription Factor Binding Site
  * Cyan = CTCF

* Selecting a Transcript
  * Click box of choosing and select the transcript ID
  * Can examine supporting evidence
  * Protein Information (reference UniProt)

* Region in detail
  * Selection Location
  * Top of page is chromosomal overview, red box denotes region of chromosome where other views on page focus on
  * Red box in Detail highlights 1mb overview of TP53
  * Scrolling further down shows most detailed location of TP53
    * Tracks can be formatted, added, removed, etc
    * Gear icon (configure) lets you add additional tracks

### Comparative Genomics

Allows you to compare Gene against multiple alignments, Gene Trees, Orthologous and Paralogues
* Gene Ortholog - homomlogous genes that diverged following evolution giving rise to new species, maintain similar function to precursor gene
  * Originate from speciation event
* Gene Paralog - homologous genes that diverged within a species, a new gene that upholds a new function
  * Come into existence during gene duplication, where a copy of the gene obtains a mutation -> new gene with new function

#### Alignments

* Pairwise - meaning two sequences at a time
* Multiple - more than two (attempt to align all sequences within a query set)

Can choose many sequences to potentially align to
* Examine full map to see areas of similar sequence
* Also look at high quality assemblies compared to low quality

#### Gene Tree
* Relation of gene between species, includes homologs

#### Orthologous
* Lists gene orthologous

#### Paralagous 
* Lists gene paralogous




