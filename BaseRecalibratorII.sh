source ReadConfig.sh $1

mapfile -t SAMPLE_array < ${WORKDIR}/${SAMPLELIST}

for SAMPLE in "${SAMPLE_array[@]}"
do
    #echo "gatk ApplyBQSR -I ${WORKDIR}/${SAMPLE}.nodup.bam --bqsr-recal-file ${WORKDIR}/${SAMPLE}.recal.table -O ${WORKDIR}/${SAMPLE}.recal.bam -R ${RESDIR}/${REF} -L ${RESDIR}/${TARGET}.bed &"
    gatk ApplyBQSR -I ${WORKDIR}/${SAMPLE}.merged.bam --bqsr-recal-file ${WORKDIR}/${SAMPLE}.recal.table -O ${WORKDIR}/${SAMPLE}.recal.bam -R ${RESDIR}/${REF} -L ${RESDIR}/${TARGET}.bed &
done > ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    gatk ApplyBQSR -I ${WORKDIR}/${line}.nodup.bam --bqsr-recal-file ${WORKDIR}/${line}.recal.table -O ${WORKDIR}/${line}.recal.bam -R ${RESDIR}/${REF} -L ${RESDIR}/${TARGET}.bed &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"
