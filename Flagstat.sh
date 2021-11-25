source ReadConfig.sh $1

FASTQ_array=$(cut -f1 ${WORKDIR}/${SAMPLELIST}Full)

for FASTQ in $FASTQ_array
do
    #echo "samtools flagstat ${WORKDIR}/${FASTQ}.sam > ${WORKDIR}/${FASTQ}.stat &"
    samtools flagstat ${WORKDIR}/${FASTQ}.sam > ${WORKDIR}/${FASTQ}.stat &
done #2>> ${WORKDIR}/README
wait


#while IFS= read -r line; do
#    samtools flagstat ${WORKDIR}/${line}.sam > ${WORKDIR}/${line}.stat &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"

