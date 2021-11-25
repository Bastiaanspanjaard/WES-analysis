source ReadConfig.sh $1

while IFS= read -r line; do
    SAMPLE_array=(${line// / })
    SAMPLE=${SAMPLE_array[1]}
    FASTQ=${SAMPLE_array[0]}
    RG="@RG\\tID:${SAMPLE}\\tSM:${SAMPLE}\\tLB:${LIBRARY}\\tPL:ILLUMINA"
    # echo "bwa mem -t 1 -M -R ${RG} ${RESDIR}/${REF} ${WORKDIR}/${FASTQ}_1.trimmed.fastq.gz ${WORKDIR}/${FASTQ}_2.trimmed.fastq.gz > ${WORKDIR}/${FASTQ}.sam &"
    bwa mem -t 1 -M -R ${RG} ${RESDIR}/${REF} ${WORKDIR}/${FASTQ}_1.trimmed.fastq.gz ${WORKDIR}/${FASTQ}_2.trimmed.fastq.gz > ${WORKDIR}/${FASTQ}.sam &
done < ${WORKDIR}/${SAMPLELIST}Full 2>> ${WORKDIR}/README
wait

echo "FINISHED"
