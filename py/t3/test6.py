#!/usr/bin/env python

result = []
for i in xrange(10):
	s = i + 2
	result.append(s)
	print 's=', s

result = [i+2 for i in xrange(10)]
for j in result:
	print 'j=', j
