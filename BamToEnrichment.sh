#!/bin/bash
#this script is for enrichment calculating between two bam files
#export PYTHONPATH=$PYTHONPATH:/woldlab/castor/proj/genome/programs/deepTools-2.4.2_develop/lib/python2.7/site-packages
#~/programs/BamToEnrichment.sh Experiment.bam Input.bam

Experiment=$(echo $1 | rev | cut -d. -f2- | rev)
Input=$(echo $2 | rev | cut -d. -f2- | rev)

/woldlab/castor/proj/genome/programs/deepTools-2.4.2_develop/bin/bamCoverage -b $Experiment.bam -o $Experiment.forward --normalizeUsingRPKM -bs 1 --filterRNAstrand reverse &
/woldlab/castor/proj/genome/programs/deepTools-2.4.2_develop/bin/bamCoverage -b $Experiment.bam -o $Experiment.reverse --normalizeUsingRPKM -bs 1 --filterRNAstrand forward &
/woldlab/castor/proj/genome/programs/deepTools-2.4.2_develop/bin/bamCoverage -b $Input.bam -o $Input.forward --normalizeUsingRPKM -bs 1 --filterRNAstrand reverse &
/woldlab/castor/proj/genome/programs/deepTools-2.4.2_develop/bin/bamCoverage -b $Input.bam -o $Input.reverse --normalizeUsingRPKM -bs 1 --filterRNAstrand forward &
/woldlab/castor/proj/genome/programs/deepTools-2.4.2_develop/bin/bamCompare -b1 $Experiment.bam -b2 $Input.bam --pseudocount 1000 --binSize 1 --normalizeUsingRPKM --samFlagInclude 16 -o $Experiment.Enrichment.pseudocount1000_bS1.reverse.bw &
/woldlab/castor/proj/genome/programs/deepTools-2.4.2_develop/bin/bamCompare -b1 $Experiment.bam -b2 $Input.bam --pseudocount 1000 --binSize 1 --normalizeUsingRPKM --samFlagExclude 16 -o $Experiment.Enrichment.pseudocount1000_bS1.forward.bw &