#!/usr/bin/env python

# -*- coding: utf-8 -*-

class Person(object):
	def __init__(self):
		print "我首先是人类"

class Programmer(Person):
	def __init__(self):
		super(Programmer, self).__init__()
		print "我是程序员"


aProgrammer = Programmer()
