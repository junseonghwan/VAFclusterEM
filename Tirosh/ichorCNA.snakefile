configfile: "/home/x_seoju/ScRNACloneEvaluation/Tirosh/config.yaml"
configfile: "/home/x_seoju/ScRNACloneEvaluation/Tirosh/samples.yaml"

rule correctDepth:
	input:
		expand("/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/{tumor}.cna.seg", tumor=config["pairings"]),
		expand("/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/{tumor}.seg.txt", tumor=config["pairings"]),
		expand("/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/{tumor}.params.txt", tumor=config["pairings"]),
		expand("/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/{tumor}.correctedDepth.txt", tumor=config["pairings"]),
		expand("/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/readDepth/{samples}.bin{binSize}.wig", samples=config["samples"], binSize=str(config["binSize"]))

rule read_counter:
	input:
		lambda wildcards: config["samples"][wildcards.samples]
	output:
		"/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/readDepth/{samples}.bin{binSize}.wig"
	params:
		readCounter=config["readCounterScript"],
		binSize=config["binSize"],
		qual="20",
		chrs=config["chrs"]
	resources:
		mem=4
	log:
		"/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/logs/readDepth/{samples}.bin{binSize}.log"
	shell:
		"{params.readCounter} {input} -c {params.chrs} -w {params.binSize} -q {params.qual} > {output} 2> {log}"

rule ichorCNA:
	input:
		tum="/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/readDepth/{tumor}.bin" + str(config["binSize"]) + ".wig",
		norm=lambda wildcards: "/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/readDepth/" + config["pairings"][wildcards.tumor] + ".bin" + str(config["binSize"]) + ".wig"
	output:
		corrDepth="/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/{tumor}.correctedDepth.txt",
		param="/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/{tumor}.params.txt",
		cna="/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/{tumor}.cna.seg",
		segTxt="/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/{tumor}.seg.txt",
		#seg="results/ichorCNA/{tumor}/{tumor}.seg",
		#rdata="results/ichorCNA/{tumor}/{tumor}.RData",
	params:
		outDir="/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/results/ichorCNA/{tumor}/",
		rscript=config["ichorCNA_rscript"],
		libdir=config["ichorCNA_libdir"],
		id="{tumor}",
		ploidy=config["ichorCNA_ploidy"],
		normal=config["ichorCNA_normal"],
		genomeStyle=config["genomeStyle"],
		gcwig=config["ichorCNA_gcWig"],
		mapwig=config["ichorCNA_mapWig"],
		estimateNormal=config["ichorCNA_estimateNormal"],
		estimatePloidy=config["ichorCNA_estimatePloidy"],
		estimateClonality=config["ichorCNA_estimateClonality"],
		scStates=config["ichorCNA_scStates"],
		maxCN=config["ichorCNA_maxCN"],
		includeHOMD=config["ichorCNA_includeHOMD"],
		chrs=config["ichorCNA_chrs"],
		#chrTrain=config["ichorCNA_chrTrain"],
		centromere=config["centromere"],
		exons=config["ichorCNA_exons"],
		txnE=config["ichorCNA_txnE"],
		txnStrength=config["ichorCNA_txnStrength"],
		fracReadsChrYMale="0.001",
		plotFileType=config["ichorCNA_plotFileType"],
		plotYlim=config["ichorCNA_plotYlim"]
	resources:
		mem=4
	log:
		"/proj/sc_ml/Tirosh/bulk-wes/CY79/cna/logs/ichorCNA/{tumor}.log"	
	shell:
		"Rscript {params.rscript} --libdir {params.libdir} --id {params.id} --WIG {input.tum} --gcWig {params.gcwig} --mapWig {params.mapwig} --NORMWIG {input.norm} --ploidy \"{params.ploidy}\" --normal \"{params.normal}\" --maxCN {params.maxCN} --includeHOMD {params.includeHOMD} --genomeStyle {params.genomeStyle} --chrs \"{params.chrs}\" --estimateNormal {params.estimateNormal} --estimatePloidy {params.estimatePloidy} --estimateScPrevalence {params.estimateClonality} --scStates \"{params.scStates}\" --centromere {params.centromere} --exons.bed {params.exons} --txnE {params.txnE} --txnStrength {params.txnStrength} --fracReadsInChrYForMale {params.fracReadsChrYMale} --plotFileType {params.plotFileType} --plotYLim \"{params.plotYlim}\" --outDir {params.outDir} > {log} 2> {log}"