class: Workflow
cwlVersion: v1.0
id: fastqc_trim_galore_workflow
label: fastqc-trim_galore-workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: 'File[]'
    'sbg:x': -1144
    'sbg:y': -103
outputs:
  - id: fastqc_result
    outputSource:
      - _fast_q_c/fastqc_result
    type: 'File[]'
    'sbg:x': -768.046875
    'sbg:y': -454.5
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': -593
    'sbg:y': -277
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': -580
    'sbg:y': -156
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': -564
    'sbg:y': -25
  - id: fastq2_trimmed_unpaired
    outputSource:
      - trim_galore/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': -592
    'sbg:y': 99
  - id: fastq2_trimmed
    outputSource:
      - trim_galore/fastq2_trimmed
    type: File?
    'sbg:x': -603
    'sbg:y': 238
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': -629
    'sbg:y': 370
  - id: fastq1_trimmed
    outputSource:
      - trim_galore/fastq1_trimmed
    type: File
    'sbg:x': -691
    'sbg:y': 501
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
    'sbg:x': -917
    'sbg:y': -326
  - id: trim_galore
    in:
      - id: fastq1
        source: seqfile
    out:
      - id: fastq1_trimmed
      - id: fastq1_trimmed_unpaired
      - id: fastq2_trimmed
      - id: fastq2_trimmed_unpaired
      - id: trim_galore_log
      - id: trimmed_fastqc_html
      - id: trimmed_fastqc_zip
    run: ./trim-galore.cwl
    'sbg:x': -892
    'sbg:y': 96
requirements: []
