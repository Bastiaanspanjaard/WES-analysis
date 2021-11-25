source ReadConfig.sh $1

mapfile -t SAMPLE_array < ${WORKDIR}/${SAMPLELIST}

for SAMPLE in "${SAMPLE_array[@]}"
do
    #echo "gatk GetPileupSummaries -I ${WORKDIR}/${SAMPLE}.recal.bam -V ${RESDIR}/small_exac_common_3.hg38.vcf.gz --intervals ${RESDIR}/${TARGET}.bed -O ${WORKDIR}/${SAMPLE}.recal.bam_getpileupsummaries.gatk.table &"
    gatk GetPileupSummaries -I ${WORKDIR}/${SAMPLE}.recal.bam -V ${RESDIR}/small_exac_common_3.hg38.vcf.gz --intervals ${RESDIR}/${TARGET}.bed -O ${WORKDIR}/${SAMPLE}.recal.bam_getpileupsummaries.gatk.table &
done 2>> ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    gatk GetPileupSummaries -I ${WORKDIR}/${line}.recal.bam -V ${RESDIR}/small_exac_common_3.hg38.vcf.gz --intervals ${RESDIR}/${TARGET}.bed -O ${WORKDIR}/${line}.recal.bam_getpileupsummaries.gatk.table &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"
