class: Workflow
cwlVersion: v1.0
id: fastqc_trim_galore_workflow
label: fastqc-trim_galore-workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: 'File[]'
    'sbg:x': -1295.5076904296875
    'sbg:y': 28.842737197875977
  - id: index_file
    type: File
    'sbg:x': -721.93701171875
    'sbg:y': 316.187744140625
  - id: fastq1
    type: File
    'sbg:x': -1272.7191162109375
    'sbg:y': 261.1015319824219
outputs:
  - id: fastqc_result
    outputSource:
      - _fast_q_c/fastqc_result
    type: 'File[]'
    'sbg:x': -828.1557006835938
    'sbg:y': -216.11148071289062
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': -584.7969360351562
    'sbg:y': -302.976318359375
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': -586.8358764648438
    'sbg:y': -184.71067810058594
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': -589.976318359375
    'sbg:y': -64.64808654785156
  - id: fastq2_trimmed_unpaired
    outputSource:
      - trim_galore/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': -590.6328125
    'sbg:y': 52.51603698730469
  - id: fastq2_trimmed
    outputSource:
      - trim_galore/fastq2_trimmed
    type: File?
    'sbg:x': -593.4297485351562
    'sbg:y': 165.53970336914062
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': -589.3519287109375
    'sbg:y': 283.8679504394531
  - id: quant_output
    outputSource:
      - kallisto_quant_se/quant_output
    type: Directory
    'sbg:x': -304.5250549316406
    'sbg:y': 435.0070495605469
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
    'sbg:x': -1018.2183227539062
    'sbg:y': -93.96947479248047
  - id: trim_galore
    in:
      - id: fastq1
        source: fastq1
    out:
      - id: fastq1_trimmed
      - id: fastq1_trimmed_unpaired
      - id: fastq2_trimmed
      - id: fastq2_trimmed_unpaired
      - id: trim_galore_log
      - id: trimmed_fastqc_html
      - id: trimmed_fastqc_zip
    run: ./trim-galore.cwl
    'sbg:x': -954.3045654296875
    'sbg:y': 171.46029663085938
  - id: kallisto_quant_se
    in:
      - id: fq
        source:
          - trim_galore/fastq1_trimmed
      - id: index_file
        source: index_file
    out:
      - id: quant_output
    run: ./kallisto-quant_se.cwl
    label: 'kallisto quant: runs the quantification algorithm'
    'sbg:x': -584.6815185546875
    'sbg:y': 437.9798889160156
requirements: []
