# This qsub script trims raw fastq files with trimmomatic

#!/bin/bash
#$ -cwd
#$ -N trimming
#$ -o /users/abaud/fmorillo/P50/mixup/output/logs/$JOB_NAME-$JOB_ID_$TASK_ID.out
#$ -e /users/abaud/fmorillo/P50/mixup/output/error/$JOB_NAME-$JOB_ID_$TASK_ID.err
#$ -t 1-1041

#Activate the multiqc environment
conda activate multiqc

#Run Trimmomatic
TRIM="/users/abaud/fmorillo/P50/mixup/output/trimmed_files/"
OUTP="/users/abaud/fmorillo/P50/mixup/output/trimmed_files/paired/"
OUTU="/users/abaud/fmorillo/P50/mixup/output/trimmed_files/unpaired/"
ADAPT="/users/abaud/data/secondary"
INPUT=$(ls /users/abaud/data/primary/P50/shallow/*R1_001.fastq.gz | grep -v "BLANK" | sort -u | sed -n ${SGE_TASK_ID}p)
I=$(echo $INPUT | sed 's/1_001.fastq.gz//')
O=$(echo $I | sed -r 's/.{38}//')
T=$(echo $O | sed 's/_R//')
trimmomatic PE -phred33 -trimlog ${TRIM}${T}_trimlog.txt ${I}1_001.fastq.gz ${I}2_001.fastq.gz ${OUTP}${O}1_paired.fq.gz ${OUTU}${O}1_unpaired.fq.gz ${OUTP}${O}2_paired.fq.gz ILLUMINACLIP:${ADAPT}Adaptors_Qiita.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36