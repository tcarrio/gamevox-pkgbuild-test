#!/usr/bin/env python3
from sys import argv
with open(argv[1],'r') as f:
	for l in f.readlines():
		if("md5sums" in l):
			gvsum=l[10:-1]
			print(gvsum)
