#!/usr/bin/env python

p = 'vttalk', 'femal', 30, 'python@qq.com'

name = p[0]
gender = p[1]
age = p[2]
cemail = p[3]

print 'name=', name, ' gender=', gender, ' age=', age, ' cemail=', cemail
print 'name=', name, ' gender=', gender, ' age=', age, ' cemail=', cemail

name, gender, age, email = p
print 'pythonic: name=', name, ' gender=', gender, ' age=', age, ' cemail=', cemail
