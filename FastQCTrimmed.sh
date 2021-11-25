source ReadConfig.sh $1

FASTQ_array=$(cut -f1 ${WORKDIR}/${SAMPLELIST}Full)

for FASTQ in $FASTQ_array
do
    fastqc -o $WORKDIR ${WORKDIR}/${FASTQ}_1.trimmed.fastq.gz &
    fastqc -o $WORKDIR ${WORKDIR}/${FASTQ}_2.trimmed.fastq.gz &
done 2>> ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    fastqc -o $WORKDIR ${WORKDIR}/${line}_1.trimmed.fastq.gz &
#    fastqc -o $WORKDIR ${WORKDIR}/${line}_2.trimmed.fastq.gz &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"
