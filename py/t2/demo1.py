#!/usr/bin/env python

import re

row = "column 1,column 2, column 3"
a1 = re.sub(r',\s*', ',', row) 
print "a1=", a1
