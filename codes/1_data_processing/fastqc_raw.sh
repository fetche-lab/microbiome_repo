# This qsub script runs fastqc in raw fastq files

#!/bin/bash
#$ -cwd
#$ -N fastqc_raw
#$ -o /users/abaud/flisso/TEST/P50_/rat_covariates/output/log_file/$JOB_NAME-$JOB_ID.out
#$ -e /users/abaud/flisso/TEST/P50_/rat_covariates/output/error_file/$JOB_NAME-$JOB_ID.err
#$ -t 1-10

#Activate fetche_LAB1 environment
conda activate fetche_LAB1

#Run fastqc
OUT="/users/abaud/flisso/TEST/P50_/rat_covariates/output/"
INPUT=$(ls /users/abaud/flisso/TEST/P50_/rat_covariates/data1/data/*.fastq.gz | sort -u | sed -n ${SGE_TASK_ID}p)
fastqc -o $OUT $INPUT
