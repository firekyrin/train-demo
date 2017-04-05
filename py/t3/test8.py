#!/usr/bin/env python

names = ['raymond', 'rachel', 'matthew', 'roger', 'betty', 'melissa', 'judith', 'charlie']
print ', '.join(names)

names.pop(0)
print ', '.join(names)

names.insert(0, 'mark')
print ', '.join(names)


from collections import deque
nicks = deque(['raymond', 'rachel', 'matthew', 'roger', 'betty', 'melissa', 'judith', 'charlie'])
print 'nicks=', ', '.join(nicks)
#nicks1 = nicks.popleft()
#print ', '.join(nicks1)
nicks2 = nicks.appendleft('mark')
print ', '.join(nicks2)
