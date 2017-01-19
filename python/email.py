#!/usr/bin/env python3
from sys import argv
with open(argv[1],'r') as f:
	for l in f.readlines():
		if("Maintainer:" in l):
			email=l[l.index('<')+1:l.index('>')]
			print(email)
