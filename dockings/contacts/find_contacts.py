import os
import sys
import numpy as np
from random import randint
from random import uniform
from random import random
from chimera import runCommand as rc # use 'rc' as shorthand for runCommand

print(" RECEIVED:")
print(sys.argv)

ligand = sys.argv[1]
target = sys.argv[2]
best_score = float(sys.argv[3])
out_file = sys.argv[4]

threshold_score = best_score + 3.0

# Opens the target file
rc("open " + target)

# Opens the ligand file
rc("viewdock " + ligand + " AutoDock")

print("="*20)

clash_command = '''findclash #1/dockScore<{threshold_score} test #0 
                   intersubmodel false 
                   overlapCutoff -0.4 
                   hbondAllowance 0.0 
                   intraRes false 
                   intraMol false 
                   saveFile {out_file} 
                   namingStyle simple'''.format(threshold_score=threshold_score, out_file=out_file)

rc(clash_command)

rc("close all")
