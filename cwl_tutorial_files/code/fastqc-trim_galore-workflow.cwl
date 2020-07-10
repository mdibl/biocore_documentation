class: Workflow
cwlVersion: v1.0
id: fastqc_trim_galore_workflow
label: fastqc-trim_galore-workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: 'File[]'
    'sbg:x': -869
    'sbg:y': 134
  - id: fastq1
    type: File
    'sbg:x': -759
    'sbg:y': -364
  - id: fastq2
    type: File
    'sbg:x': -754
    'sbg:y': -114
outputs:
  - id: console_log
    outputSource:
      - _fast_q_c/console_log
    type: stdout
    'sbg:x': -384
    'sbg:y': 273
  - id: error_log
    outputSource:
      - _fast_q_c/error_log
    type: stderr
    'sbg:x': -382
    'sbg:y': 170
  - id: fastqc_result
    outputSource:
      - _fast_q_c/fastqc_result
    type: 'File[]'
    'sbg:x': -375
    'sbg:y': 32
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': 4
    'sbg:y': -519
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': 1
    'sbg:y': -394
  - id: console_log_1
    outputSource:
      - trim_galore/console_log
    type: stdout
    'sbg:x': -121
    'sbg:y': 505
  - id: error_log_1
    outputSource:
      - trim_galore/error_log
    type: stderr
    'sbg:x': -75
    'sbg:y': 382
  - id: fastq1_trimmed
    outputSource:
      - trim_galore/fastq1_trimmed
    type: File
    'sbg:x': -48
    'sbg:y': 246
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': -1
    'sbg:y': 121
  - id: fastq2_trimmed
    outputSource:
      - trim_galore/fastq2_trimmed
    type: File?
    'sbg:x': 1
    'sbg:y': -14
  - id: fastq2_trimmed_unpaired
    outputSource:
      - trim_galore/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': 3
    'sbg:y': -162
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': 5
    'sbg:y': -277
steps:
  - id: _fast_q_c
    in:
      - id: seqfile
        source:
          - seqfile
    out:
      - id: console_log
      - id: error_log
      - id: fastqc_result
    run: ./FastQC.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -617
    'sbg:y': 132
  - id: trim_galore
    in:
      - id: fastq1
        source:
          - fastq1
          - fastq2
    out:
      - id: console_log
      - id: error_log
      - id: fastq1_trimmed
      - id: fastq1_trimmed_unpaired
      - id: fastq2_trimmed
      - id: fastq2_trimmed_unpaired
      - id: trim_galore_log
      - id: trimmed_fastqc_html
      - id: trimmed_fastqc_zip
    run: ./trim-galore.cwl
    'sbg:x': -331
    'sbg:y': -236
requirements:
  - class: MultipleInputFeatureRequirement
