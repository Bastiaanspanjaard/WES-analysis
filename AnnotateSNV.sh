source ReadConfig.sh $1

/local/users/Bastiaan/Scripts/annovar/convert2annovar.pl -format vcf4 -allsample -withfreq ${WORKDIR}/${PATIENT}.PASS.vcf > ${WORKDIR}/${PATIENT}.PASS.variants 2>> ${WORKDIR}/README
/local/users/Bastiaan/Scripts/annovar/annotate_variation.pl -geneanno -buildver hg38 -dbtype refGene ${WORKDIR}/${PATIENT}.PASS.variants /local/users/Bastiaan/Scripts/annovar/humandb/ 2>> ${WORKDIR}/README
