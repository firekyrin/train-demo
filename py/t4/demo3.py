#!/usr/bin/env python

import threading
import time

class WorkThread(threading.Thread):
	def __init__(self, signal):
		threading.Thread.__init__(self)
		self.signal = signal

	def run(self):
		print("girl %s, sleep..." % self.name)
		self.signal.wait()
		print("girl %s, wakeup..." % self.name)

if __name__ == "__main__":
	signal = threading.Event()
	for t in xrange(0, 6):
		thread = WorkThread(signal)
		thread.start()

	print("3 seconds after wake girl up")
	time.sleep(3)
	signal.set()
