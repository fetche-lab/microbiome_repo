#Count the number of reads R1/R2 raw files and put it in a text file that can be used as a database in R

#!/bin/bash

#$ -cwd 
#$ -N raw_read_counts
#$ -o /users/abaud/fmorillo/P50/microbiome/output/logs/$JOB_NAME-$JOB_ID.out 
#$ -e /users/abaud/fmorillo/P50/microbiome/output/error/$JOB_NAME-$JOB_ID.err
#$ -q long-sl7
#$ -l virtual_free=20G

OUT="/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/"
touch ${OUT}raw_read_counts.txt
echo "run_prefix,raw_read_numbers" > ${OUT}raw_read_counts.txt
for INPUT in $(ls /users/abaud/data/primary/P50/shallow/*R?_001.fastq.gz | sort | grep -v "BLANK")
        do
          	LINENUM=$(zcat ${INPUT} | wc -l)
                OUTPUT=$(echo -n "${INPUT},$(($LINENUM / 4))" | sed -r 's/.{38}//' | sed 's/_001.fastq.gz//')
		echo $OUTPUT >> ${OUT}raw_read_counts.txt
        done
