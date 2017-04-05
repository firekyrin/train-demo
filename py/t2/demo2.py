#!/usr/bin/env python

import re

sentence = "from 12/22/1629 to 11/14/1643"
a2 = re.sub(r'(\d{2})/(\d{2})/(\d{4})', r'\3-\1-\2', sentence)

print "a2=", a2
