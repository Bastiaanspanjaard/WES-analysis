source ReadConfig.sh $1

FASTQ_array=$(cut -f1 ${WORKDIR}/${SAMPLELIST}Full)

for FASTQ in $FASTQ_array
do
    #echo "samtools depth ${WORKDIR}/${FASTQ}.sorted.bam > ${WORKDIR}/${FASTQ}.sorted.bam.depth &"
    samtools depth ${WORKDIR}/${FASTQ}.sorted.bam > ${WORKDIR}/${FASTQ}.sorted.bam.depth &
done 2>> ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    samtools depth ${WORKDIR}/${line}.sorted.bam > ${WORKDIR}/${line}.sorted.bam.depth &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"
