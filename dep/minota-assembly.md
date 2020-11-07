# Introduction to De Novo Transcriptome Assembly

Welcome back to the MDIBL MINOTA Workshop! Today we're going to be discussing De Novo Transcriptome Assembly. We'll start by a brief introduction to the rationale behind assembly, followed by a review of some tools that are commonly implemented.

We'll be focusing primarily on Trinity, the main assembler for this course; delving into how it functions, and its algorithmic processes. Included will be a brief review of the importance of pre-processing your data before assembly, as well as some utilities that come built into the software package.

## De novo Transcriptome Assembly: Trinity

## Trinity: Overview

We'll first start with quick overview, before we dive into the details of how Trinity as a whole functions. Trinity takes its name from the three software modules that make up the core of the assembler.

The first component is Inchworm, and is responsible for assembling sequencing data into linear contigs. Next is Chrysalis, which groups constructed contigs that are related, (either due to alternative splicing or gene duplication), and builds de bruijn graphs. Lastly, Butterfly is examines input reads in the context of the de bruijn graphs, reporting the complete and final full-length transcripts and isoforms of transcripts.

## Inchworm Algorithm

Inchworm first decomposes reads into a catalog of overlapping kmers (overlapping 25-mers by default). This portion is very similar to the initial step of constructing a de Bruijn graph, though one isn't actually being built. The kmers are stored, along with frequency in reads. Edges between the kmers are not, to save on memory + computational resources.

The single-most abundant kmer that has some level of reasonable sequence complexity is identified as a "seed" kmer, which is then extended at the 3' end and guided by the coverage of overlapping kmers. For every extension that occurs, there exist four possible kmers, with each ending with one of the four nucleotides.

Each of the possible overlapping kmers is then looked up in the kmer catalog to determine frequency in reads
For this specific example, the kmer ending with 'G' is found 4 times

'A' is found once

The kmer ending with 'T' doesn't exist in the reads, so its count is 0

The kmer ending with 'C' is found 4 times

Now a tie exists between 'G' and 'C'

When a tie is encountered, the graph branches out, and the tied paths are explored recursively to locate the extension that provides the highest cumulative coverage

In this case, the extension of two overlapping kmers ending with an 'A' provides the highest cumulative coverage, and the other paths are ignored







## Contact
If you have questions about the information in this workshop document, please contact:

```
Nathaniel Maki
Bioinformatics Training Specialist
MDI Biological Laboratory
nmaki[at]mdibl.org
```