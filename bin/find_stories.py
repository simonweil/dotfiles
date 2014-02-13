#!/usr/local/bin/python

import os
import sys
# check https://pypi.python.org/pypi/colorama for better color support (includes bg and styles too)
from colorama import Fore, Back, Style

# Check arguments
if len(sys.argv) < 2:
	print("Usage: " + os.path.basename(sys.argv[0]) + " <story-id> [<story-id>...]")
	exit()


for story in sys.argv:
	if sys.argv[0] != story:
		title = "Story: " + story

		print(Fore.GREEN + "\n----" + "-" * len(title) + "\n- " + Fore.BLUE + title + Fore.GREEN + " -\n----" + "-" * len(title))


		# Run git to get all commits
		#run_command = "git log --grep '[(|,]" + story + "[)|,]' --pretty=oneline"
		run_command = "git log --format='%H [%ad] [%cn] - %s' --date=relative --grep '" + story + "'"
		from subprocess import Popen, PIPE
		p = Popen(run_command , shell=True, stdout=PIPE, stderr=PIPE)
		out, err = p.communicate()
		#print("Return code: " + str(p.returncode))
		#print(out.rstrip(), err.rstrip())
		print(out.rstrip())


#git log --grep "(NISITES-" --pretty=oneline
#git log --format="%H [%ad] [%cn] - %s" --date=relative
