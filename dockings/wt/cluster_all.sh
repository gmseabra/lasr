#!/bin/bash

ligands=" 1a 1g 23a 23g 23h C12 LBA "

for lig in $ligands;
do
	echo $lig
	sed "s/LIGAND/$lig/g" cpptraj_clustering.in > temp.in
	cpptraj -i temp.in
	rm temp.in
done
