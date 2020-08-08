import argparse
import glob
import os
import re
import subprocess
import sys
import time

import numpy as np

PATH_TO_PROCESSING_SCRIPT  =  "./RunBSCITE.sh" # path to B-SCITE executable
PATH_TO_EXECUTABLE  =  "/Users/seonghwanjun/ScRNACloneEvaluation/B-SCITE/src/bscite.exe" # path to B-SCITE executable
parser = argparse.ArgumentParser(description='Script to batch run simulation studies.')
parser.add_argument('case_path', help="Path to simulation case.", type=str)
parser.add_argument('-t', '--threshold', help="Path to simulation case.", type=int, default = 3)
parser.add_argument('--sbegin', help="Sim begin.", type=int, default = 0)
parser.add_argument('--send', help="Sim end (not inclusive).", type=int, default = 10)
parser.add_argument('--rbegin', help="Rep begin.", type=int, default = 0)
parser.add_argument('--rend', help="Rep end (not inclusive).", type=int, default = 10)
args = parser.parse_args()

CASE_PATH = args.case_path
SIM_BEGIN = args.sbegin
SIM_END = args.send
REP_BEGIN = args.rbegin
REP_END = args.rend
SC_VAR_THRESHOLD = args.threshold

fp = 0.01 # esimated false positive rate of SCS experiment
fn = 0.2     # estimated false negative rate of SCS experiment
n  = 100      # number of mutations
#m  = 100      # number of cells
r  = 1       # number of repeats
l  = 10000    # number of loops

for sim_no in range(SIM_BEGIN, SIM_END):
	SIMUL_PATH = CASE_PATH + "/sim" + str(sim_no)
	for rep_no in range(REP_BEGIN, REP_END):
		REP_PATH = SIMUL_PATH + "/rep" + str(rep_no) + "/"

		run_command = PATH_TO_PROCESSING_SCRIPT + " "
		run_command += REP_PATH + " "
		run_command += str(SC_VAR_THRESHOLD)
		os.system(run_command)

		OUTPUT_FILES_PREFIX = REP_PATH + "/bscite/bscite" # this is the prefix used for the three output files (.matrices, .gv and .newick) given as the output of B-SCITE
		SCFile   = os.path.join(REP_PATH, "bscite/bscite.SC") # path input SC File
		bulkFile = os.path.join(REP_PATH, "bscite/bscite.bulk")     # path input bulk file

		cell_count = np.loadtxt(os.path.join(REP_PATH, "bscite", "cell_count.txt"), dtype=int, ndmin=1)[0]

		run_command = ""
		run_command += PATH_TO_EXECUTABLE + " "
		run_command += "-i "   + SCFile   + " "
		run_command += "-bulkFileLocation " + bulkFile + " "
		run_command += "-n "  + str(n)  + " "
		run_command += "-m "  + str(cell_count)  + " "
		run_command += "-fd " + str(fp) + " "
		run_command += "-ad " + str(fn) + " "
		run_command += "-r "  + str(r)  + " "
		run_command += "-l "  + str(l)  + " "
		run_command += "-o "  + OUTPUT_FILES_PREFIX + " "
		os.system(run_command)
