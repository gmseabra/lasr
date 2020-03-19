#!/bin/bash


"""
Loops through all ligands and, for each ligand, through all targets, to find all
contacts between ligand-target. 

Uses UCSF Chimera and the script 'find_contacts.py' for it.

__author__ = Gustavo seabra

"""
root_dir=/home/seabra/work/cnpd3/lasr/docking/ensemble
targets_mod=/home/seabra/work/cnpd3/lasr/md/TARGET/analysis/aligned_TARGET_cluster
dockings_file=${root_dir}/best_all.dat
results_dir=${root_dir}/contacts
chimera="/opt/UCSF/Chimera64-1.14/bin/chimera"

while IFS= read -r line
do
    tokens=( ${line} )
    target=${tokens[0]}
    if [[ "$target" != "Variant" ]]
    then

        ligand=${tokens[1]}
        best=${tokens[6]}

        echo "Getting results for docking $ligand to $target, the best is $best"

        for cluster in `seq -w 00 14`
        do
            target_file=$( echo $targets_mod | sed "s/TARGET/${target}/g" ).c${cluster}.pdb
            # ../wt/OUT_03_LBC_2_ex-128.pdbqt
            for run in `seq 1 3`
            do
                ligand_file=${root_dir}/${target}/OUT_${cluster}_${ligand}_${run}_ex-128.pdbqt
                results_file=${results_dir}/${target}_${cluster}_${ligand}_${run}.dat
                echo "      TARGET: " $target_file
                echo "      LIGAND: " $ligand_file
                $chimera  --nogui  --script  "find_contacts.py ${ligand_file} ${target_file} ${best} ${results_file}"
            done
        done
    fi
done < $dockings_file
