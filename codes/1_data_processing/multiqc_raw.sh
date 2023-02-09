# This qsub script runs fastqc in raw fastq files

#!/bin/bash
#$ -cwd
#$ -N multiqc_raw
#$ -o /users/abaud/fmorillo/P50/mixup/output/logs/$JOB_NAME-$JOB_ID.out
#$ -e /users/abaud/fmorillo/P50/mixup/output/error/$JOB_NAME-$JOB_ID.err

#Activate the multiqc environment
conda activate multiqc

#Run multiqc
cd /users/abaud/fmorillo/P50/mixup/output/fastqc_files/fastqc_raw/
multiqc .
