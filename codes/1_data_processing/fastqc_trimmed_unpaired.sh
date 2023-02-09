# This qsub script runs fastqc for unpaired fastq files

#!/bin/bash
#$ -cwd
#$ -N fastqc_trimmed_unpaired
#$ -o /users/abaud/fmorillo/P50/mixup/output/logs/$JOB_NAME-$JOB_ID.out
#$ -e /users/abaud/fmorillo/P50/mixup/output/error/$JOB_NAME-$JOB_ID.err
#$ -t 1-2082

#Activate the multiqc environment
conda activate multiqc

#Run fastqc
OUT="/users/abaud/fmorillo/P50/mixup/output/fastqc_files/fastqc_trimmed_unpaired/"
INPUT=$(ls /users/abaud/fmorillo/P50/mixup/output/trimmed_files/unpaired/*.fq.gz | sort -u | sed -n ${SGE_TASK_ID}p)
fastqc -o $OUT $INPUT
