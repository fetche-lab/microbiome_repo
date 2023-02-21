# This qsub script runs fastqc in raw fastq files

#!/bin/bash
#$ -cwd
#$ -N multiqc_trimmed
#$ -o /users/abaud/flisso/TEST/P50_/rat_covariates/output/q15/log_file/$JOB_NAME-$JOB_ID.out
#$ -e /users/abaud/flisso/TEST/P50_/rat_covariates/output/q15/error_file/$JOB_NAME-$JOB_ID.err

#Activate the fetche_LAB1 environment
conda activate fetche_LAB1 

#Run multiqc_paired
cd /users/abaud/flisso/TEST/P50_/rat_covariates/output/trimmed_testing/fastqc_trimmed/paired/q15/
multiqc .

#Run multiqc_unpaired
cd /users/abaud/flisso/TEST/P50_/rat_covariates/output/trimmed_testing/fastqc_trimmed/unpaired/q15/
multiqc .
