#!/usr/bin/env python

import threading

def run(number):
	print(threading.currentThread().getName() + '\n')
	print(number)

if __name__ == '__main__':
	for i in xrange(10):
		my_thread = threading.Thread(target=run, args=(i,))
		my_thread.start()
