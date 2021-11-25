source ReadConfig.sh $1

DBSNP=${RESDIR}/Homo_sapiens_assembly38.dbsnp138.vcf
MILLS=${RESDIR}/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
MILGEN=${RESDIR}/1000G.phase3.integrated.sites_only.no_MATCHED_REV.hg38.vcf
mapfile -t SAMPLE_array < ${WORKDIR}/${SAMPLELIST}

for SAMPLE in "${SAMPLE_array[@]}"
do
    #echo "gatk BaseRecalibrator -R ${RESDIR}/${REF} -I ${WORKDIR}/${SAMPLE}.nodup.bam --known-sites ${DBSNP} --known-sites ${MILLS} -O ${WORKDIR}/${SAMPLE}.recal.table -L ${RESDIR}/${TARGET}.bed &  "
    gatk BaseRecalibrator -R ${RESDIR}/${REF} -I ${WORKDIR}/${SAMPLE}.merged.bam --known-sites ${DBSNP} --known-sites ${MILLS} -O ${WORKDIR}/${SAMPLE}.recal.table -L ${RESDIR}/${TARGET}.bed &
done 2>> ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    gatk BaseRecalibrator -R ${RESDIR}/${REF} -I ${WORKDIR}/${line}.nodup.bam --known-sites ${DBSNP} --known-sites ${MILLS} -O ${WORKDIR}/${line}.recal.table -L ${RESDIR}/${TARGET}.bed &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

echo "FINISHED"
