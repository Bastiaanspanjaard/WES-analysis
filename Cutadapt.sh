# Reading config
source ReadConfig.sh $1

# Commands
ADAPTERS_FILE=${RESDIR}/AdaptersByLibrary
ADAPTER_FORWARD=`awk -F " " -v library=$LIBRARY '{if ($1 == library) {print $2}}' $ADAPTERS_FILE`
ADAPTER_REVERSE=`awk -F " " -v library=$LIBRARY '{if ($1 == library) {print $3}}' $ADAPTERS_FILE`

echo "Starting cutadapt"
FASTQ_array=$(cut -f1 ${WORKDIR}/${SAMPLELIST}Full)
for FASTQ in $FASTQ_array
do
    R_ONE=($ORIDIR/$FASTQ*R1*.fastq.gz)
    R_TWO=($ORIDIR/$FASTQ*R2*.fastq.gz)
    cutadapt -m 70 -a $ADAPTER_FORWARD -A $ADAPTER_REVERSE -o ${WORKDIR}/${FASTQ}_1.trimmed.fastq.gz -p ${WORKDIR}/${FASTQ}_2.trimmed.fastq.gz $R_ONE $R_TWO > ${WORKDIR}/${FASTQ}.Cutadapt.log &
done 2>> ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    R_ONE=($ORIDIR/$line*R1*.fastq.gz)
#    R_TWO=($ORIDIR/$line*R2*.fastq.gz)
#    cutadapt -m 70 -a $ADAPTER_FORWARD -A $ADAPTER_REVERSE -o ${WORKDIR}/${line}_1.trimmed.fastq.gz -p ${WORKDIR}/${line}_2.trimmed.fastq.gz $R_ONE $R_TWO > ${WORKDIR}/${line}.Cutadapt.log &
#done < ${WORKDIR}/${SAMPLELIST} 2>> ${WORKDIR}/README
#wait

#echo "Cutadapt finished"
