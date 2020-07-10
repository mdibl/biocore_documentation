class: Workflow
cwlVersion: v1.0
id: workflow_pe
label: workflow_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: 'File[]'
    'sbg:x': -830
    'sbg:y': -570
  - id: seqfile2
    type: 'File[]'
    'sbg:x': -820
    'sbg:y': -431
  - id: fastq1
    type: File
    'sbg:x': -930
    'sbg:y': -62
  - id: fastq2
    type: File
    'sbg:x': -916
    'sbg:y': 112
  - id: index_file
    type: File
    'sbg:x': -276
    'sbg:y': 171
outputs:
  - id: fastqc_result
    outputSource:
      - _fast_q_c/fastqc_result
    type: 'File[]'
    'sbg:x': -351
    'sbg:y': -569
  - id: fastqc_result_1
    outputSource:
      - _fast_q_c_1/fastqc_result
    type: 'File[]'
    'sbg:x': -357
    'sbg:y': -432
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': -486
    'sbg:y': -273
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': -414
    'sbg:y': -172
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': -381
    'sbg:y': -72
  - id: fastq2_trimmed_unpaired
    outputSource:
      - trim_galore/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': -381
    'sbg:y': 50
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': -429
    'sbg:y': 299
  - id: quant_output
    outputSource:
      - kallisto_quant_pe/quant_output
    type: Directory
    'sbg:x': 199
    'sbg:y': 330
steps:
  - id: _fast_q_c
    in:
      - id: seqfile
        source:
          - seqfile
    out:
      - id: fastqc_result
    run: ./FastQC.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -603
    'sbg:y': -569
  - id: _fast_q_c_1
    in:
      - id: seqfile
        source:
          - seqfile2
    out:
      - id: fastqc_result
    run: ./FastQC.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -594
    'sbg:y': -432
  - id: trim_galore
    in:
      - id: fastq1
        source:
          - fastq1
          - fastq2
    out:
      - id: fastq1_trimmed
      - id: fastq1_trimmed_unpaired
      - id: fastq2_trimmed
      - id: fastq2_trimmed_unpaired
      - id: trim_galore_log
      - id: trimmed_fastqc_html
      - id: trimmed_fastqc_zip
    run: ./trim-galore.cwl
    'sbg:x': -722
    'sbg:y': 21
  - id: kallisto_quant_pe
    in:
      - id: fq1
        source: trim_galore/fastq2_trimmed
      - id: fq2
        source: trim_galore/fastq1_trimmed
      - id: index_file
        source: index_file
    out:
      - id: quant_output
    run: ./kallisto-quant_pe.cwl
    label: 'kallisto quant: runs the quantification algorithm'
    'sbg:x': -93
    'sbg:y': 342
requirements:
  - class: MultipleInputFeatureRequirement
