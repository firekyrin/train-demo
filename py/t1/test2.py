#!/usr/bin/env python

class Person:
	def fun(myself):
		print "just a fun.%s" %(myself.__class__)

aPerson = Person()
aPerson.fun()
