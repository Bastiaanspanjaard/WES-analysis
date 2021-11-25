source ReadConfig.sh $1

FASTQ_array=$(cut -f1 ${WORKDIR}/${SAMPLELIST}Full)

for FASTQ in $FASTQ_array
do
    R_ONE=($ORIDIR/$FASTQ*R1*.fastq.gz)
    R_TWO=($ORIDIR/$FASTQ*R2*.fastq.gz)
    fastqc -o $WORKDIR $R_ONE &
    fastqc -o $WORKDIR $R_TWO &
done 2>> ${WORKDIR}/README
wait

#while IFS= read -r line; do
#    R_ONE=($ORIDIR/$line*R1*.fastq.gz)
#    R_TWO=($ORIDIR/$line*R2*.fastq.gz)
#    fastqc -o $WORKDIR $R_ONE &
#    fastqc -o $WORKDIR $R_TWO &
#done < ${WORKDIR}/${SAMPLELIST}Full 2>> ${WORKDIR}/README
#wait
