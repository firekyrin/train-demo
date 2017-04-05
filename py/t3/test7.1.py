#!/usr/bin/env python

import urllib

def cache(func):
	saved = {}

	def wrapper(url):
		if url in saved:
			return saved[url]
		else:
			page = func(url)
			saved[url] = page
			return page

	return wrapper

@cache
def web_lookup(url):
	return urllib.urlopen(url).read()

url = 'https://www.baidu.com'
page = web_lookup(url)
print 'url=', url
print 'page=', page
