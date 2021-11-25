source ReadConfig.sh $1

HEALTHY=`head -1 ${WORKDIR}/${CONTROL}`
TUMOR_array=$(diff ${WORKDIR}/${SAMPLELIST} ${WORKDIR}/${CONTROL} | grep '^<' | cut -d " " -f2)

for TUMOR in $TUMOR_array
do
    gatk CalculateContamination -I ${WORKDIR}/${TUMOR}.recal.bam_getpileupsummaries.gatk.table -O ${WORKDIR}/${TUMOR}.recal.bam_calculatecontamination.gatk.table -matched ${WORKDIR}/${HEALTHY}.recal.bam_getpileupsummaries.gatk.table &
done 2>> ${WORKDIR}/README
wait

echo "FINISHED"
