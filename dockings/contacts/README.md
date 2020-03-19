# Obtaining contact data

To obtain the contacts data a combination of bash, awk and Python/Chimera scripts was used:
 
1.	Dockings file: contains information in the best docking results for each ligand/target combination (Supplementary Table 1).
2.	Bash script find_all_contacts.sh: loops through each combination of target/ligand to launch the chimera/python script to locate the contacts.
3.	Python script find_contacts.py: Receives:
	a.	Ligand .pdbqt file
	b.	Target PDB file
	c.	Binding energy (Vina Score) for reference
	d.	Name of the results file
	e. 	Launches Chimera to calculate the contacts with the findclash command

4.	Bash script collect_results.sh: loops through all results and uses awk to count the contacts by each target/ligand pair.
5.	AWK script count_contacts.awk: accumulates the contacts by residue for each target/ligand pair

