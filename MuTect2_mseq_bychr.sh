source ReadConfig.sh $1

HEALTHY=`head -1 ${WORKDIR}/${CONTROL}`
SAMPLES=$( diff ${WORKDIR}/${SAMPLELIST} ${WORKDIR}/${CONTROL} | grep '^<' | cut -d " " -f2 | awk -v healthyname=${HEALTHY} -v dir=$WORKDIR 'BEGIN{printf "-I "dir"/"healthyname".recal.bam "}{printf "-I "dir"/"$0".recal.bam "}' | tr '\n' ' ')
#We select all the samples to pass them to Mutect2
GERMRES=${RESDIR}/af-only-gnomad.hg38.vcf.gz

# Here, loop over chromosomes for calling and filtering (every chromosome can be done in parallel).

while IFS= read -r CHR; do
    gatk --java-options "-Xmx4G" Mutect2 -R ${RESDIR}/${REF} ${SAMPLES} -normal ${HEALTHY} \
         --germline-resource ${GERMRES} --disable-read-filter MateOnSameContigOrNoMappedMateReadFilter \
         -L $CHR -O ${WORKDIR}/Mutect2_mseq.${CHR}.${PATIENT}.vcf \
         -bamout ${WORKDIR}/Mutect2_mseq.${CHR}.bamout \
        -pon ${RESDIR}/1000g_pon.hg38.vcf.gz &
done < ${RESDIR}/chromosomes.txt 2>> ${WORKDIR}/README
wait

echo "`date`: Started filtering" >> ${WORKDIR}/README_pipesteps
CONTABLES=$( diff ${WORKDIR}/${SAMPLELIST} ${WORKDIR}/${CONTROL} | grep '^<' | cut -d " " -f2 | awk -v healthyname=${HEALTHY} -v chr=${CHR} -v dir=$WORKDIR '{printf "-contamination-table "dir"/"$0".recal.bam_calculatecontamination.gatk.table "}' | tr '\n' ' ')
while IFS= read -r CHR; do
    gatk FilterMutectCalls \
        -V ${WORKDIR}/Mutect2_mseq.${CHR}.${PATIENT}.vcf \
        -O ${WORKDIR}/Mutect2_mseq.${CHR}.${PATIENT}.filtered.vcf \
        -R ${RESDIR}/${REF} \
        $CONTABLES \
        --stats ${WORKDIR}/Mutect2_mseq.${CHR}.${PATIENT}.vcf.stats &
done < ${RESDIR}/chromosomes.txt 2>> ${WORKDIR}/README
wait

echo "FINISHED"
