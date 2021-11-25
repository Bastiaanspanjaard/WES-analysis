source ReadConfig.sh $1

# Loop over samples; for each sample first identify all fastqs (and therefore bams) belonging to that sample, and provide them all as input to one MarkDuplicate process.
# The outcome of MarkDuplicate is a bam-file without duplicates and with all fastqs merged.

mapfile -t SAMPLE_array < ${WORKDIR}/${SAMPLELIST}

for SAMPLE in "${SAMPLE_array[@]}"
do
    #echo "Sample: ${SAMPLE}"
    INPUT_BAMS=`awk -v wd=$WORKDIR -v sample=$SAMPLE '{if($2==sample){printf("I=%s/%s.sorted.bam ", wd, $1)}} END{printf("\n")}' ${WORKDIR}/${SAMPLELIST}Full`
    #echo $INPUT_BAMS
    #echo "java -XX:ParallelGCThreads=12 -jar /local/users/Bastiaan/gatk/gatk-4.1.9.0/picard/build/libs/picard.jar MarkDuplicates $INPUT_BAMS O=${WORKDIR}/${SAMPLE}.nodup.bam MAX_FILE_HANDLES=500 CREATE_INDEX=true TMP_DIR=${WORKDIR}/${SAMPLE}_Temp METRICS_FILE=${WORKDIR}/${SAMPLE}.MarkDuplicatesMetrics.txt VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE & "
    java -XX:ParallelGCThreads=12 -jar /local/users/Bastiaan/gatk/gatk-4.1.9.0/picard/build/libs/picard.jar MarkDuplicates $INPUT_BAMS O=${WORKDIR}/${SAMPLE}.nodup.bam MAX_FILE_HANDLES=500 CREATE_INDEX=true TMP_DIR=${WORKDIR}/${SAMPLE}_Temp METRICS_FILE=${WORKDIR}/${SAMPLE}.MarkDuplicatesMetrics.txt VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE &
    #FASTQ_array=(`awk -v sample=$SAMPLE '$2==sample {print $1}' ${WORKDIR}/${SAMPLELIST}Full`)
    #echo "Fastq-array: ${FASTQ_array[*]}"
    #echo "samtools depth ${WORKDIR}/${FASTQ}.sorted.bam > ${WORKDIR}/${FASTQ}.sorted.bam.depth &"
    #samtools depth ${WORKDIR}/${FASTQ}.sorted.bam > ${WORKDIR}/${FASTQ}.sorted.bam.depth &
done #2>> ${WORKDIR}/README
wait


#while IFS= read -r line; do
#    java -XX:ParallelGCThreads=12 -jar /local/users/Bastiaan/gatk/gatk-4.1.9.0/picard/build/libs/picard.jar MarkDuplicates I=${WORKDIR}/${line}.sorted.bam O=${WORKDIR}/${line}.nodup.bam MAX_FILE_HANDLES=500 CREATE_INDEX=true TMP_DIR=${WORKDIR}/${line}_Temp METRICS_FILE=${WORKDIR}/${line}.MarkDuplicatesMetrics.txt VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"
