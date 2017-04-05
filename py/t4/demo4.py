#!/usr/bin/env python
# coding=utf8

import os
import sys
import atexit

def daemonize(pid_file=None):
	"""
		创建守护进程
		:param pid_file: 保存进程id的文件
		:return:
	"""

	pid= os.fork()

	if pid:
		sys.exit(0)

	os.chdir('/')
	os.umask(0)
	os.setsid()

	_pid = os.fork()
	if _pid:
		sys.exit(0)

	sys.stdout.flush()
	sys.stderr.flush()

	with open('/dev/null') as read_null, open('/dev/null', 'w') as write_null:
		os.dup2(read_null.fileno(), sys.stdin.fileno())
		os.dup2(write_null.fileno(), sys.stdout.fileno())
		os.dup2(write_null.fileno(), sys.stderr.fileno())

	if pid_file:
		with open(pid_file, 'w+') as f:
			f.write(str(os.getpid()))

			atexit.register(os.remove, pid_file)


if __name__ == '__main__':
	daemonize('./aa.txt')
