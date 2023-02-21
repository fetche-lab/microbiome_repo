# This qsub script runs fastqc for unpaired fastq files

#!/bin/bash
#$ -cwd
#$ -N fastqc_trimmed_unpaired
#$ -o /users/abaud/flisso/TEST/P50_/rat_covariates/output/q15/log_file/$JOB_NAME-$JOB_ID.out
#$ -e /users/abaud/flisso/TEST/P50_/rat_covariates/output/q15/error_file/$JOB_NAME-$JOB_ID.err
#$ -t 1-3

#Activate the fetche_LAB1 environment
conda activate fetche_LAB1

#Run fastqc
OUT="/users/abaud/flisso/TEST/P50_/rat_covariates/output/trimmed_testing/fastqc_trimmed/unpaired/q15/"
INPUT=$(ls /users/abaud/flisso/TEST/P50_/rat_covariates/output/trimmed_testing/unpaired/q15/*.fq.gz | sort -u | sed -n ${SGE_TASK_ID}p)
fastqc -o $OUT $INPUT
