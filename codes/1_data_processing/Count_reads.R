#Open the databases to evaluate taxonomic profiling with Progenomes (only paired) & SD Rats Metagenome Gene Catalogue
raw <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/raw_read_counts_R1.txt")
paired_trimmed <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/trimmed_paired_read_counts_R1.txt")
non_host <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/nohost_trimmed_read_counts_R1.txt")

#Kaiju (GTDB)
kaiju_gtdb_domain <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/kaijux_gtdb_domain.txt", sep="\t")
kaiju_gtdb_phylum <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/kaijux_gtdb_phylum.txt", sep="\t")
kaiju_gtdb_class <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/kaijux_gtdb_class.txt", sep="\t")
kaiju_gtdb_order <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/kaijux_gtdb_order.txt", sep="\t")
kaiju_gtdb_family <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/kaijux_gtdb_family.txt", sep="\t")
kaiju_gtdb_genus <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/kaijux_gtdb_genus.txt", sep="\t")
kaiju_gtdb_species <- read.csv("/nfs/users/abaud/fmorillo/P50/microbiome/output/analyses/read_counting/kaijux_gtdb_species.txt", sep="\t")

#Prepare the comparison table
comp_tab <- data.frame(Sample=raw$run_prefix,Reads_Before_Trimming=raw$raw_read_numbers,Reads_After_Trimming_Paired=paired_trimmed$trimmed_paired_read_numbers,Non_Host_Reads=non_host$nohost_trimmed_read_numbers)
#Include Kaiju reads
comp_tab$Aligned_Reads_kaiju_gtdb <- kaiju_gtdb_domain$aligned_reads
comp_tab$Assigned_Reads_kaiju_gtdb_Domain <- kaiju_gtdb_domain$assigned_reads
comp_tab$Assigned_Reads_kaiju_gtdb_Phylum <- kaiju_gtdb_phylum$assigned_reads
comp_tab$Assigned_Reads_kaiju_gtdb_Class <- kaiju_gtdb_class$assigned_reads
comp_tab$Assigned_Reads_kaiju_gtdb_Order <- kaiju_gtdb_order$assigned_reads
comp_tab$Assigned_Reads_kaiju_gtdb_Family <- kaiju_gtdb_family$assigned_reads
comp_tab$Assigned_Reads_kaiju_gtdb_Genus <- kaiju_gtdb_genus$assigned_reads
comp_tab$Assigned_Reads_kaiju_gtdb_Species <- kaiju_gtdb_species$assigned_reads

##Create ratios
###Trimmed
comp_tab$Proportion_Remaining_Reads_After_Trimming <- comp_tab$Reads_After_Trimming_Paired / comp_tab$Reads_Before_Trimming
###Non-host
comp_tab$Proportion_Non_Host_Reads_From_Paired_Trimmed <- comp_tab$Non_Host_Reads / comp_tab$Reads_After_Trimming_Paired
###Aligned to annotated sequences
comp_tab$Proportion_Aligned_Reads_kaiju_gtdb <- comp_tab$Aligned_Reads_kaiju_gtdb / comp_tab$Non_Host_Reads
###Classified to a taxonomy
comp_tab$Proportion_Assigned_Reads_kaiju_gtdb_Phylum <- comp_tab$Assigned_Reads_kaiju_gtdb_Phylum / comp_tab$Aligned_Reads_kaiju_gtdb
comp_tab$Proportion_Assigned_Reads_kaiju_gtdb_Class <- comp_tab$Assigned_Reads_kaiju_gtdb_Class / comp_tab$Aligned_Reads_kaiju_gtdb
comp_tab$Proportion_Assigned_Reads_kaiju_gtdb_Order <- comp_tab$Assigned_Reads_kaiju_gtdb_Order / comp_tab$Aligned_Reads_kaiju_gtdb
comp_tab$Proportion_Assigned_Reads_kaiju_gtdb_Family <- comp_tab$Assigned_Reads_kaiju_gtdb_Family / comp_tab$Aligned_Reads_kaiju_gtdb
comp_tab$Proportion_Assigned_Reads_kaiju_gtdb_Genus <- comp_tab$Assigned_Reads_kaiju_gtdb_Genus / comp_tab$Aligned_Reads_kaiju_gtdb
comp_tab$Proportion_Assigned_Reads_kaiju_gtdb_Species <- comp_tab$Assigned_Reads_kaiju_gtdb_Species / comp_tab$Aligned_Reads_kaiju_gtdb

#View(comp_tab)
summary(comp_tab)

dir="/users/abaud/fmorillo/P50/microbiome/output/analyses/mapping_quality/"
save(comp_tab, file=paste(dir, 'kaiju_gtdb_read_counts.RData',sep=''))
