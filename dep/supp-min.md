# Introduction to Quality Control

## Learning Objectives

* Become familiar with an integral component of any sequence analysis process (and why you should include it)
* Learn common techniques in accounting for variations in quality of read or transcriptomic data

## Jumping In: FASTA vs FASTQ

Our first foray into Quality Control (or QC, as we'll call it from here on out), is in these two very similar-but-not file formats

For those of you not familiar, FASTA, or rather, the FASTA filetype, is a text format that's used to represent nucleotide and/or peptide sequence records, with individual letter codes denoting base pairs and/or amino acids

FASTA files are comprised of a detailed single line, with the sequence information below it:

```
>1 dna:chromosome chromosome:GRCz11:1:1:59578282:1 REF
GATCTTAAACATTTATTCCCCCTGCAAACATTTTCAATCATTACATTGTCATTTCCCCTC
CAAATTAAATTTAGCCAGAGGCGCACAACATACGACCTCTAAAAAAGGTGCTGTAACATG
TACCTATATGCAGCACCACTATATGAGAGCGGCATAGCAGTGTTTAGTCACTTGGTTGCT
TTGTTTATATTAACTTGAAAGTGTGTTTTAGCTATTGAGTTTAAACAAAGGGAGCGGTTT
ACATTGAATTAAAGGCAACTACTGATGGGTTGTGTAATGTTTCAAAGAGCTGTTGCAGCA
TGAGTGGAAAATAAAACCGTATTAGTGCTGCCTGGCCCAGTTTGGCACAAAATGGAGCGA
TTCCATTAAGAGAACGATTCAGCATAAGTGGAACAGCTAAAGTTTATGAAAATTTTTAAT
CTGGATGTAGAGAATCTCATAACACAGAAACAGCACTCCTAAAGATGCATTTATACTTCT
GCATAGAGCACACAAGTATGCTTCAGCACAACCTGTGCATGGTCACATAGCCCTTGCTGT
```

Above is an excerpt taken from a Zebrafish reference genome (ensembl release 101)

Now, you'd be forgiven for thinking that FASTA is a perfectly fine file format, and in truth, it is

However, it's missing a key component, and that blank space is where FASTQ comes in

A recurring theme of not only this workshop, but (in my opinion) the field of Bioinformatics as a whole,
is to always be questioning your data, and to never make preliminary assumptions

The FASTQ filetype arose due to the occurrence of variation in base calls during sequencing

Most sequencers fluorescently label DNA fragments, encoding the nucleobases (comprised of A, T, G, or C) millions of times over, and storing the output in images 

These images contain specifically colored pixels, which are then separated from one another and assigned a value

Because of the vast quantities of pixels present on a single image, and the fact that many of them overlap, it's difficult to determine which color goes to which pixel

Take this process, and extrapolate it across the varying lengths of sequence fragments (for length 50, 50 images produced), and you start to get an idea as to where mistakes may be made

The images are then analyzed, and a color spectra produced for each pixel over all the images, with the spectra for a single pixel representing a read

```
Insert neat spectrum image here
```

Base calling comes into play when determining which base goes to which position based upon their signal

Overlapping and/or decaying signals can muddy the waters so to speak, and makes selecting the proper base a challenge

This is what determines base calling quality, the estimated probability (confidence) that the correct base was chosen

FASTA had no built-in way of representing these "confidence scores", and therefore, no reliable way to provide an overview on the quality of a sequence

FASTQ, being an evolution of FASTA, includes quality scoring following each sequence, which is represented using the Phred scoring format

Phred encoding legend
```
 Quality encoding: !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHI
                   |         |         |         |         |
    Quality score: 0........10........20........30........40 
```
Phred scores are logarithmically based, calculated using
```
Q = -10 log10(P), where P accounts for the probability that the call is incorrect
```
 Phred Quality Score | Probability of incorrect base call | Base call accuracy 
 :------------------ | :--------------------------------: | -----------------: 
 10 | 1 in 10 | 90% 
 20 | 1 in 100 | 99% 
 30 | 1 in 1000 | 99.9% 
 40 | 1 in 10000 | 99.99% 
 50 | 1 in 100000 | 99.999% 
 60 | 1 in 1000000 | 99.9999% 

FASTQ files are made up of four lines; a sequence identifier, 
the sequence itself, Quality score ID line, and the Quality score

```
@HISEQ:224:C8BH2ANXX:5:1101:1416:1955 1:N:0:CAAACCC
NCGCTCATCTGGCCACGTGCTGCCAAGAGCTCCTCCTCGTGGTTCTTCTT
+
#<<B/BBFFFF/BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFF<
@HISEQ:224:C8BH2ANXX:5:1101:1723:1939 1:N:0:CAAACCC
NTACCTCTCAACGGTTTCACGCCCTGTTGAACTCTCTCTTCAAAGTTCTT
+
#<<BBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
@HISEQ:224:C8BH2ANXX:5:1101:2235:1979 1:N:0:CAAACCC
NCCTTAATAGTGCACTACTTGAGGGAGCAGCCATTTTTAGAGGAGTCAGA
```

The file above was generated from an Illumina HISEQ sequencer using
cluster generation and SBS (sequencing by synthesis)

This method differs from the one described above, sequencing millions of clusters that exist on a flow cell

For this process, base calls are made for every cluster and stored per cycle-of-sequencing by Illumina Real-Time Analysis software

(continue)

## QC Pre-Analysis

Before conducting QC and running your reads through tools such as trim_galore or Trimmomatic, a good practice is to first generate a baseline summary of quality for downstream comparison

A quick and easy way to do this is using the FastQC software package

Executable through both a desktop application and command line, FastQC builds an HTML report made up of modular analyses, and is complimented by supplementary tables and graphs

Below are a few interactive reports provided by the developers of FastQC, differentiating between good and poor input sequences

[Good](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/good_sequence_short_fastqc.html) sequence quality

[Poor](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html) sequence quality

## Quality Control by Trimming

While some may consider trimming to be an unnecessary step, I'd argue that it's one of the most important; excising unwanted or error-ridden portions of your input data can vastly improve mapping and alignment accuracy

Trimming can clean up adapter sequences that have been left behind, repeat contamination such as strings of A's or T's, and/or poor quality 3' and 5' end bases

When conducting QC on experimental data, there are quite a few tools to choose from; we'll be focusing on the two mentioned above: trim_galore and Trimmomatic

Trim_galore is comprised of two tools, Cutadapt and FastQC

The first component, Cutadapt, assists in improving the quality of downstream analyses by removing extraneous adapter sequences, poly-A tails, primers, and low quality transcripts from an input read file(s)

The second component, FastQC, was already described above. A question that may arise is "if FastQC is a pre-QC step, why run it again and after trimming"? 

Mainly, it's to provide another point of comparison for your input data; Running FastQC on your trimmed reads will further highlight what was causing contamination, and you'll be able to examine the difference between both reports generated.

Something worth mentioning is that for Trim_galore to function properly, both FastQC and and Cutadapt must be installed prior.

*look for error-laden fastq file, run through fastqc for adapter detection