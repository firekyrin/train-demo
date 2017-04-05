#!/usr/bin/env python

f = open('data.txt')
try:
	data = f.read()
	print 'data=', data
finally:
	f.close()


with open('data.txt') as f:
	data = f.read()
	print 'data=', data
	
