source ReadConfig.sh $1

FASTQ_array=$(cut -f1 ${WORKDIR}/${SAMPLELIST}Full)

for FASTQ in $FASTQ_array
do
    #echo "bedtools genomecov -ibam ${WORKDIR}/${FASTQ}.sorted.bam -g ${RESDIR}/${REF} > ${WORKDIR}/${FASTQ}.genomecov &"
    bedtools genomecov -ibam ${WORKDIR}/${FASTQ}.sorted.bam -g ${RESDIR}/${REF} > ${WORKDIR}/${FASTQ}.genomecov &
done 2>> ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    bedtools genomecov -ibam ${WORKDIR}/${line}.sorted.bam -g ${RESDIR}/${REF} > ${WORKDIR}/${line}.genomecov &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"

