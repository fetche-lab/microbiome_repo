# This qsub script runs fastqc in raw fastq files

#!/bin/bash
#$ -cwd
#$ -N multiqc_raw
#$ -o /users/abaud/flisso/TEST/P50_/rat_covariates/output/log_file/$JOB_NAME-$JOB_ID.out
#$ -e /users/abaud/flisso/TEST/P50_/rat_covariates/output/error_file/$JOB_NAME-$JOB_ID.err

#Activate the fetche_LAB1 environment
conda activate fetche_LAB1

#Run multiqc
cd /users/abaud/flisso/TEST/P50_/rat_covariates/output/fastq_raw_zipped/
multiqc . 
mv multiqc_report* /users/abaud/flisso/TEST/P50_/rat_covariates/microbiome_repo/fastqc_raw_reports/
