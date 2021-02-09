---
title: Introduction to UniProt
author: "Nathaniel Maki"
organization: MDIBL Computational Core
date: "January 24th"
---

# Introduction to UniProt

## Summary

* Universal Protein Resource - comprehensive resource of protein sequence and functional information
* Supported by EMBL-EBI / PIR (Protein Information Resource) / SIB (Swiss Institute of Bioinformatics)
* Data is pulled from resources such as Ensembl, INSDC (NCBI, DDBJ, ENA), and direct submission

Most of data (90%) in Uniprot comes from translations of coding sequences that have been user submitted to INSDC

## Resources

UniProtKB
* Contains functional + structural data on proteins, sourced from Swiss-Prot and TrEMBL
  * Swiss-Prot submissions are manually annotated + reviewed
  * TrEMBL submissions are automatically annotated, not reviewed

Proteomes
* Protein sets expressed by organisms
* Provides proteomes from completely sequenced genomes

UniParc
* Database that contains most of the publically available protein sequences

UniRef
* Provides clustered set of sequences
* Useful for examining sequence conservation between species

## UniProtKB

TrEMBL
* All direct submissions go to TrEMBL
* Once reviewed and manually annotated, moved to Swiss-Prot

Swiss-Prot
* All entries are manually reviewed by curators
* Contain detailed info about protein function that may be missing/incomplete on TrEMBL initial submissions

## How to Access Data

Search bar defaults to UniProtKB (can change with dropdown)

`Quick Access Tiles` let you search specific resource

`Getting Started` takes you to tools such as BLAST

All data on Uniprot can also be accessed programatically

### Free Text Search
Can query by
* protein name
* gene name
* species
* disease
* keywords
* GO term

### Advanced Search
Much like Entrez, allows for advanced query building, combining any accepted terms to produce output

### Results page
Can refine results by using `filter` function on left side of page, filter by organism as well as reviewed or unreviewed resource (querying for `TP53`)

### Retrieve/ID Mapping
Plug multiple queries into search box
* TP53, BRAC2
* Choose `From Gene Name` and `To UniProtKB`
* Organism is `Homo sapiens`

### Explore Protein Sequences + Features
Use Blast + Align to locate similar proteins both within species and in different ones
* Paste sequence into BLAST box
* Set Target db to UniProtKB

Identity column on right shows how similar search query is to protein sequence in results

BLAST results can be filtered by normal means (reviewed, organism, etc)

### Align
Align 2 or more sequences to locate regions of similarity, or find conserved regions
* Run alignment using: `TPA_HUMAN TPA_PIG`
* `*` means Conserved residues (Proteins that have fewer AA replacements) (Exactly same in all sequences)
* `:` Strong similar properties (AA that aren't same but have similar chemical properties)
* `.` Weak similar properties (AA that aren't same, weaker chemical properties)

## Accessing Proteomes
Proteome contains a set of proteins theorized to be expressed by an organism
* for species that have fully sequenced genomes
* contain protein sequence and functional information for large swath of species
* Allows for cross-species comparison of orthology + conservation

### Reference Proteomes
Subset of proteomes - best annotated for a chosen taxonomic group
* for well studied model organisms + species of interest

#### Query Proteomes
Homo sapiens as an example
* can be mapped to both reviewed and unreviewed resources for comparison

