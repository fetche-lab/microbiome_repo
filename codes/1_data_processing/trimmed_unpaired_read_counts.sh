#Count the number of reads of R1/R2 unpaired trimmed files and put it in a text file that can be used as a database in R
#!/bin/bash

#$ -cwd 
#$ -N trimmed_unpaired_read_counts
#$ -o /users/abaud/fmorillo/P50/microbiome/output/logs/$JOB_NAME-$JOB_ID.out 
#$ -e /users/abaud/fmorillo/P50/microbiome/output/error/$JOB_NAME-$JOB_ID.err
#$ -l virtual_free=50G
#$ -q long-sl7

OUT="/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/"
touch ${OUT}trimmed_unpaired_read_counts.txt
echo "run_prefix,trimmed_unpaired_read_numbers" > ${OUT}trimmed_unpaired_read_counts.txt
for INPUT in $(ls /users/abaud/fmorillo/P50/mixup/output/trimmed_files/unpaired/*unpaired.fq.gz | sort )
        do
          	LINENUM=$(zcat ${INPUT} | wc -l)
                OUTPUT=$(echo -n "${INPUT},$(($LINENUM / 4))" | sed -r 's/.{62}//' | sed 's/_unpaired.fq.gz//')
		echo $OUTPUT >> ${OUT}trimmed_unpaired_read_counts.txt
        done
