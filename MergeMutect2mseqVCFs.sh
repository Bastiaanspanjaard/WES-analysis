source ReadConfig.sh $1

HEALTHY=`head -1 ${WORKDIR}/${CONTROL}`
SAMPLES=$( diff ${WORKDIR}/${SAMPLELIST} ${WORKDIR}/${CONTROL} | grep '^<' | cut -d " " -f2 | awk -v healthyname=${HEALTHY} -v dir=$WORKDIR 'BEGIN{printf "-I "dir"/"healthyname".recal.bam "}{printf "-I "dir"/"$0".recal.bam "}' | tr '\n' ' ') #We select all the samples to pass them to MultiSNV

INPUTS=$(for i in {1..22}; do 
    echo "I="${WORKDIR}/Mutect2_mseq.chr$i.${PATIENT}.filtered.vcf" "; 
done; 
echo "I="${WORKDIR}/Mutect2_mseq.chrX.${PATIENT}.filtered.vcf " "; 
echo "I="${WORKDIR}/Mutect2_mseq.chrY.${PATIENT}.filtered.vcf " "; 
echo "I="${WORKDIR}/Mutect2_mseq.chrM.${PATIENT}.filtered.vcf " ";)

java -jar /local/users/Bastiaan/gatk/gatk-4.1.9.0/picard/build/libs/picard.jar MergeVcfs $INPUTS D=${RESDIR}/Homo_sapiens_assembly38.dict O=${WORKDIR}/${PATIENT}.vcf

awk '{split($0,a,"");if(a[1]=="#" || $7=="PASS"){print $0}}' ${WORKDIR}/${PATIENT}.vcf > ${WORKDIR}/${PATIENT}.PASS.vcf

echo "FINISHED"
