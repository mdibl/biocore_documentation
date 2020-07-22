cwlVersion: v1.0
class: CommandLineTools
label: "TAPAS - Diff APA site analysis: conducts differential analysis between two biological samples"
doc: >
    "Accoring to the central dogma of molecular biology, a pre-mRNA is synthesized from the coding sequence of a gene during the transcriptional process. 
    This pre-mRNA is coverted into a (mature) mRNA by the post-transcriptional process. The post-transcriptional process consists of three major steps. 
    One of them is the addition of polyadenylation (polyA) tail using the polyadenylation pocess, which in turn consists of two substeps: 
    cleavage at the 3' end of the pre-mRNA and addition of a polyA tail at the cleavage site. But, due to the effect of certain cis-acting elements and 
    trans-acting factors, alternative cleavage sites can be formed from in a pre-mRNA. More precisely, a single pre-mRNA may often produce more than one 
    mRNA with 3' untranslated regions (3' UTRs) of different lengths. TAPAS is a tool for detecting such alternative (or all) polyadenylation (APA) sites 
    within a gene from RNA-Seq data. If two biological samples with multiple replicates are given, TAPAS can indentify differentially expressed APA sites 
    between the samples. Moreover, its differential analysis has been extended to discover the shortening/lengthening of 3' UTRs within a gene."

hints:
  DockerRequirement:
    dockerImageId: tapas:latest

baseCommand: [Diff_APA_site_analysis]