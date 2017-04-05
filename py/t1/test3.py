#!/usr/bin/env python

class Person:
	def setName(self, name):
		self.name = name

	def getName(self):
		return self.name

	def greet(self):
		print "Hello, world! I'm %s." % self.name


class Programmer(Person):
	def setUsingLanguage(self, language):
		self.language = language

	def getLanguage(self):
		return self.language

	def greet(self):
		print "Hello, world! I'm %s, I use %s language." %(self.name, self.language)


aProgrammer = Programmer()
aProgrammer.name = "XiShiiOS"
aProgrammer.language = "ObjC"
aProgrammer.greet()
