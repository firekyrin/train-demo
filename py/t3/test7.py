#!/usr/bin/env python

import urllib
#import urllib.request as urllib

def web_lookup(url, saved={}):
	if url in saved:
		return saved[url]
	page = urllib.urlopen(url).read()
	saved[url] = page
	return page

url = 'https://www.baidu.com'
page = web_lookup(url)
print 'url=', url
print 'page=', page
