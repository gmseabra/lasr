#!/bin/bash

ligands=" 1a 1g 23a 23g 23h C12 LBA "

for lig in $ligands;
do
	echo $lig
	awk 'BEGIN{
		MOL=0
		} 
		{
			if ($0~"REMARK FILE") 
				{
					MOL=MOL+1;
				        FILE=$3;
					MODEL=$5;
					getline;
					ENERG=$4;	
					printf"%5d \t %s \t MODEL %s \t SCORE = %5.2f \n", MOL, FILE, MODEL, ENERG
				}
			}' filtered_${lig}.pdb > ${lig}.index
done

