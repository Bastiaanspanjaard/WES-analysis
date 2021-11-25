source ReadConfig.sh $1

FASTQ_array=$(cut -f1 ${WORKDIR}/${SAMPLELIST}Full)

for FASTQ in $FASTQ_array
do
    #echo "java -jar /local/users/Bastiaan/gatk/gatk-4.1.9.0/picard/build/libs/picard.jar SortSam I=${WORKDIR}/${FASTQ}.sam TMP_DIR=${WORKDIR}/sort${FASTQ} O=${WORKDIR}/${FASTQ}.sorted.bam CREATE_INDEX=true SORT_ORDER=coordinate &"
    mkdir ${WORKDIR}/sort${FASTQ}
    java -jar /local/users/Bastiaan/gatk/gatk-4.1.9.0/picard/build/libs/picard.jar SortSam I=${WORKDIR}/${FASTQ}.sam TMP_DIR=${WORKDIR}/sort${FASTQ} O=${WORKDIR}/${FASTQ}.sorted.bam CREATE_INDEX=true SORT_ORDER=coordinate
done 2>> ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    mkdir ${WORKDIR}/sort${line}
#    java -jar /local/users/Bastiaan/gatk/gatk-4.1.9.0/picard/build/libs/picard.jar SortSam I=${WORKDIR}/${line}.sam TMP_DIR=${WORKDIR}/sort${line} O=${WORKDIR}/${line}.sorted.bam CREATE_INDEX=true SORT_ORDER=coordinate &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"
