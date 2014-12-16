#!/bin/bash
mkdir -p results


############ Liability Estimation Part ###############

#Find related individuals to remove
python findRelated.py --bfilesim dataset1/dataset1 --out results/dataset1.related

#Compute heritability estimates for every excluded chromosome
seq 1 10 | xargs -i --max-procs=2 bash -c "python calc_h2.py --bfilesim dataset1/dataset1 --extractSim dataset1/extracts/nochr{}_extract.txt --prev 0.001 --numRemovePCs 10 --pheno dataset1/dataset1.phe --related results/dataset1.related --h2coeff 1.0 | tail -1 | cut -d\" \" -f2 > results/dataset1_nochr{}.h2"

# #Estimate liabilities
seq 1 10 | xargs -i --max-procs=2 bash -c "python probit.py --bfilesim dataset1/dataset1 --pheno dataset1/dataset1.phe --prev 0.001 --extractSim dataset1/extracts/nochr{}_extract.txt --out results/dataset1_nochr{} --related results/dataset1.related --h2 \`cat results/dataset1_nochr{}.h2\`"

