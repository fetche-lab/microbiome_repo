#!/bin/bash
#$ -cwd
#$ -N bowtie2_no_host
#$ -o /users/abaud/fmorillo/P50/microbiome/output/logs/$JOB_NAME-$JOB_ID_$TASK_ID.out
#$ -e /users/abaud/fmorillo/P50/microbiome/output/error/$JOB_NAME-$JOB_ID_$TASK_ID.err
#$ -t 1-1041
#$ -q long-sl7
#$ -l virtual_free=30G

REF="/users/abaud/data/secondary/indexes/bowtie2/Rnor_6.0/Rnor_6.0"
OUT="/users/abaud/fmorillo/P50/microbiome/output/no_host_files/"

conda activate sam

INPUT_P=$(ls /users/abaud/fmorillo/P50/mixup/output/trimmed_files/paired/*R1_paired.fq.gz | sort -u | sed -n ${SGE_TASK_ID}p)
INPUT_U=$(ls /users/abaud/fmorillo/P50/mixup/output/trimmed_files/unpaired/*R1_unpaired.fq.gz | sort -u| sed -n ${SGE_TASK_ID}p)
IP=$(echo $INPUT_P | sed 's/1_paired.fq.gz//')
IU=$(echo $INPUT_U | sed 's/1_unpaired.fq.gz//')
O=$(echo $IP | sed -r 's/.{60}//' | sed 's/_R//')

#Alignment with host reference genome
bowtie2 -x ${REF} -1 ${IP}1_paired.fq.gz -2 ${IP}2_paired.fq.gz -U ${IU}1_unpaired.fq.gz,${IU}2_unpaired.fq.gz -S ${OUT}${O}_aligned.sam

#Conversion of Sam to Bam
samtools view -bS ${OUT}${O}_aligned.sam > ${OUT}${O}_aligned.bam
rm ${OUT}${O}_aligned.sam

#Removal of host reads
samtools view -b -f 12 -F 256 ${OUT}${O}_aligned.bam > ${OUT}${O}_no_host.bam
rm ${OUT}${O}_aligned.bam

#Sorting
samtools sort -n ${OUT}${O}_no_host.bam -o ${OUT}${O}_no_host_sorted.bam
rm ${OUT}${O}_no_host.bam

#Creation of new fastq files with no host reads
samtools fastq ${OUT}${O}_no_host_sorted.bam -1 ${OUT}${O}_R1_nohost.fastq.gz -2 ${OUT}${O}_R2_nohost.fastq.gz
rm ${OUT}${O}_no_host_sorted.bam
