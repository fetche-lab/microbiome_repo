# This qsub script trims raw fastq files with trimmomatic

#!/bin/bash
#$ -cwd
#$ -N trimming
#$ -o /users/abaud/flisso/TEST/P50_/rat_covariates/output/q15/log_file/$JOB_NAME-$JOB_ID.out
#$ -e /users/abaud/flisso/TEST/P50_/rat_covariates/output/q15/error_file/$JOB_NAME-$JOB_ID.err
#$ -t 1-3

#Activate the fetche_LAB1 environment
conda activate fetche_LAB1

#Run Trimmomatic
TRIM="/users/abaud/flisso/TEST/P50_/rat_covariates/output/trimmed_testing/"
OUTP="/users/abaud/flisso/TEST/P50_/rat_covariates/output/trimmed_testing/paired/q15/"
OUTU="/users/abaud/flisso/TEST/P50_/rat_covariates/output/trimmed_testing/unpaired/q15/"
ADAPT="/users/abaud/flisso/TEST/P50_/rat_covariates/microbiome_repo/codes/1_data_processing/Adaptors_Qiita.fa"
INPUT=$(ls /users/abaud/flisso/TEST/P50_/rat_covariates/data1/data/*R1_001.fastq.gz | sort -u | sed -n ${SGE_TASK_ID}p)
I=$(echo $INPUT | sed 's/1_001.fastq.gz//')
O=$(echo $I | sed -r 's/.{56}//')
trimmomatic PE -phred33 ${I}1_001.fastq.gz ${I}2_001.fastq.gz ${OUTP}${O}1_paired.fq.gz ${OUTU}${O}1_unpaired.fq.gz ${OUTP}${O}2_paired.fq.gz ILLUMINACLIP:${ADAPT}Adaptors_Qiita.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
