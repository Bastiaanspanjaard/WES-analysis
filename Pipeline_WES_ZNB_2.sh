#!/bin/bash
# SNVs calling of dbh:MYCN zebrafish (neuroblastoma model).

# Reading configuration file
source ReadConfig.sh $1

# Samples and chromosomes counting
number_samples=`wc -l ${WORKDIR}/${SAMPLELIST} | awk '{print $1}'`    # Total number of samples
number_fastqs=`wc -l ${WORKDIR}/${SAMPLELIST}Full | awk '{print $1}'`    # Number of fastqs (R1 and R2 are one)
nchrs=`cat ${RESDIR}/chromosomes.txt | wc -l`     # Total number of chromosomes
ntumors=`diff ${WORKDIR}/${SAMPLELIST} ${WORKDIR}/${CONTROL} | grep '^<'| wc -l`  # Total number of tumor samples
echo "Analyzing "$number_samples" samples, including $ntumors tumor samples"
njobs_bytumor_bychr=$(( nchrs*ntumors ))   # When splitting by chromosomes for each tumor sample

# Create a folder and put slurm output inside
#mkdir -p ${WORKDIR}
#cd ${WORKDIR}
rm ${WORKDIR}/README
echo "Launched at `date`" > ${WORKDIR}/README_pipesteps
echo "Using Configuration file $1" >> ${WORKDIR}/README_pipesteps

# Fastqc on raw fastq files
echo "`date`: Started fastqcraw." >> ${WORKDIR}/README_pipesteps
source FastQCRaw.sh $1

# Cutadapt to trim fastq files
#echo "`date`: Started cutadapt." >> ${WORKDIR}/README_pipesteps
#source Cutadapt.sh $1

# Fastqc on trimmed fastq files
#echo "`date`: Started fastqctrimmed." >> ${WORKDIR}/README_pipesteps
#source FastQCTrimmed.sh $1

# Align using bwa
#echo "`date`: Started aligning." >> ${WORKDIR}/README_pipesteps
#source BWA.sh $1

# Flagstat
#echo "`date`: Started flagstat." >> ${WORKDIR}/README_pipesteps
#source Flagstat.sh $1

# Sortsam
#echo "`date`: Started sortsam." >> ${WORKDIR}/README_pipesteps
#source SortSam.sh $1

# Genomecov
#echo "`date`: Started genomecov." >> ${WORKDIR}/README_pipesteps
#source Genomecov.sh $1

# SamtoolsDepth
#echo "`date`: Started samtoolsdepth." >> ${WORKDIR}/README_pipesteps
#source SamtoolsDepth.sh $1

# Mark duplicates, merge fastq files
#echo "`date`: Started markduplicates." >> ${WORKDIR}/README_pipesteps
#source MarkDuplicatesAndMerge.sh $1
#echo "`date`: Started merging." >> ${WORKDIR}/README_pipesteps
#source MergeBamFiles.sh $1

# Note that merging bam files is only necessary when there are multiple paired fastqs per sample - IS THIS STILL NECESSARY?

# Baserecalibrator
#echo "`date`: Started BaseRecalibratorI." >> ${WORKDIR}/README_pipesteps
#source BaseRecalibratorI.sh $1
#echo "`date`: Started BaseRecalibratorII." >> ${WORKDIR}/README_pipesteps
#source BaseRecalibratorII.sh $1

# Calculate Pileups
# In contrast to Laura, I am calculating pileups for all samples and then, in the next sample, calculate contamination of piled-up tumor sample with respect to piled-up normal
#echo "`date`: Started getpileup." >> ${WORKDIR}/README_pipesteps
#source GetPileup.sh $1

# Calculate contamination
#echo "`date`: Started contamination calculation." >> ${WORKDIR}/README_pipesteps
#source CalculateContamination.sh $1

# Run Mutect2 parallel by chromosome
#echo "`date`: Started mutation calling." >> ${WORKDIR}/README_pipesteps
#source MuTect2_mseq_bychr.sh $1

# Merge Mutect2 results
#echo "`date`: Started MergeMutect." >> ${WORKDIR}/README_pipesteps
#source MergeMutect2mseqVCFs.sh $1

# Annotate calls
#echo "`date`: Started annotating SNVs." >> ${WORKDIR}/README_pipesteps
#source AnnotateSNV.sh $1

##### 
# COPY NUMBER

#Regular
#conda deactivate
#conda activate CNVkit

# CNVKit bins
#echo "`date`: Started CNV bin creation." >> ${WORKDIR}/README_pipesteps
#source CNVkit_access.sh $1

# CNVkit proper
#echo "`date`: Started CNVkit." >> ${WORKDIR}/README_pipesteps
#source CNVkit.sh $1

#conda deactivate
#conda activate WES

# Allele-specific
# Sequenza wiggle
#echo "`date`: Creating sequenza GC-wiggle file." >> ${WORKDIR}/README_pipesteps
#source Sequenza_wiggle.sh $1

# Sequenza bam2seqz
#echo "`date`: Running Sequenza bam2seqz." >> ${WORKDIR}/README_pipesteps
#source Sequenza.sh $1

# Sequenza binning
#echo "`date`: Running Sequenza binning." >> ${WORKDIR}/README_pipesteps
#source Sequenza_binning.sh $1

# SequenzaR to call copy numbers
#echo "`date`: Running SequenzaR." >> ${WORKDIR}/README_pipesteps
#source SequenzaR.sh $1

#jid_Facets=$(sbatch --array=2-${ntumors} -t 5:00:00 -p amd-shared --qos amd-shared ${SCRIPTDIR}/Facets.sh $1 | awk '{print $4}')
#echo "Facets.sh Job ID $jid_Facets"  | tee -a ${WORKDIR}/$slurm_info/README


#######
# CLONAL DECONVOLUTION


#jid_PycloneVi=$(sbatch --array=1 -t 0:30:00 -p amd-shared --qos amd-shared ${SCRIPTDIR}/PyClone-vi.sh $1 | awk '{print $4}')
#echo "PyClone-vi.sh Job ID $jid_PycloneVi"  | tee -a ${WORKDIR}/$slurm_info/README

echo "PIPELINE LAUNCHED"
