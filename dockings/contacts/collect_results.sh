#!/bin/bash

targets=" wt w60f d73n y56f "
ligands=" 1a 23a 23g 23h 1g LBC C12 "
for ligand in $ligands
do
    for target in $targets
    do
        printf "Processing interactions between ${target}\tand\t${ligand}...\t "
        awk '$1 ~ "#" {print}' data/${target}_*_${ligand}_*.dat > contacts_${target}-${ligand}.dat
        awk -f count_contacts.awk contacts_${target}-${ligand}.dat > summary_${target}-${ligand}.tsv
        rm contacts_${target}-${ligand}.dat
        printf "Done. \n"
    done
done