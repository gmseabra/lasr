import sys
import glob

best_res = sys.argv[1]
max_dif = 1.0

thresholds = {}

with open(best_res) as best:
    for line in best:
        tokens = line.split()
        if tokens[0] == "wt":
            ligand = tokens[1]
            thresh = float(tokens[6]) + max_dif
            thresholds[ligand] = thresh

for lig in thresholds.keys():
    print(f"Ligand {lig}: \t THRESH = {thresholds[lig]:5.2f}")

    threshold = thresholds[lig]
    outfile   = f"pdb/filtered_{lig}.pdb"
    pdbqt_filenames = f"pdbqt/OUT_??_{lig}*.pdbqt"
    pdb_files = [f for f in glob.glob(pdbqt_filenames)]

    filtered = list()

    for pdb_file in pdb_files:
        with open(pdb_file,"r") as infile:

            for line in infile:
                header = line.split()[0]
                if header == "MODEL":
                    # This is a new model, intialize model
                    model = []
                    model.append(line)
                    info = f"REMARK FILE {pdb_file}  MODEL {line.split()[1]}\n"
                    model.append(info)
                elif header == "REMARK" and line.split()[1] == "VINA":
                    # This is the line with the Vina score
                    score = float(line.split()[3])
                    model.append(line)
                elif header == "HETATM" or header == "ATOM":
                    # Atom information
                    model.append(line)
                elif header == "ENDMDL":
                    # Model end
                    model.append(line)
                    if score <= threshold:
                        filtered = filtered + model

    with open(outfile,"w") as of:
        for line in filtered:
            of.write(line)
