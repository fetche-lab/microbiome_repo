# This qsub script trims raw fastq files with trimmomatic

#!/bin/bash
#$ -cwd
#$ -N trimming
#$ -o /users/abaud/flisso/TEST/P50/shallow/output/log_file/$JOB_NAME-$JOB_ID_$TASK_ID.out
#$ -e /users/abaud/flisso/TEST/P50/shallow/output/error_file/$JOB_NAME-$JOB_ID_$TASK_ID.err
#$ -t 1-5

#Activate the fetche_LAB1 environment
conda activate fetche_LAB1

#Run Trimmomatic
TRIM="/users/abaud/flisso/TEST/P50/shallow/output/trimmed_files/"
OUTP="/users/abaud/flisso/TEST/P50/shallow/output/trimmed_files/trimmed_q15/paired/"
OUTU="/users/abaud/flisso/TEST/P50/shallow/output/trimmed_files/trimmed_q15/unpaired/"
ADAPT="/users/abaud/flisso/TEST/P50/shallow/microbiome_repo/codes/1_data_processing/"
INPUT=$(ls /users/abaud/flisso/TEST/P50/shallow/data1/data/*R1_001.fastq.gz | sort -u | sed -n ${SGE_TASK_ID}p)
I=$(echo $INPUT | sed 's/1_001.fastq.gz//')
O=$(echo $I | sed -r 's/.{49}//')
trimmomatic PE -phred33 ${I}1_001.fastq.gz ${I}2_001.fastq.gz ${OUTP}${O}1_paired.fq.gz ${OUTU}${O}1_unpaired.fq.gz ${OUTP}${O}2_paired.fq.gz ILLUMINACLIP:${ADAPT}Adaptors_Qiita.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
