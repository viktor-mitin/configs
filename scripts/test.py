#!/usr/bin/env python
#
# PURPOSE: Get rutracker.org torrent file from current firefox url
#
#

import pexpect
import re
import os
import sys
import urllib
import urlparse

def get_current_url():
    child = pexpect.spawn ('telnet localhost 4242')
    child.expect ('repl>')
    child.sendline ('content.location.href')
    child.expect ('repl>')
    child.sendline ('repl.quit()')

    result = child.before 
    current_url = result.split()[1]
    current_url = current_url.strip('"')
    return current_url

def get_torrent(current_url):
    child = pexpect.spawn ('telnet localhost 4242')
    child.expect ('repl>')
    child.sendline ('content.location.href = \'%s\'' % current_url)
    child.expect ('repl>')
    child.sendline ('repl.quit()')

    result = child.before 
    print result
    exit()
    return result

def readURL(url):
    """Returns the file found in the URL
    """
    f = urllib.urlopen(url)
    data = f.read()
    f.close()
    return data

def saveURL(url):
    """Reads the given URL, saves the file """
    #get the folder name 
    folder = (urlparse.urlparse(url)[2])[1:]
    #this will have the filename too
    filename = os.path.basename(folder)

    if filename == '':
        print "Cannot detect filename"
        exit(1)
    
    #read the data from URL
    data = readURL(url)

    fname  = foldername  + os.sep + filename
    fname1 = foldername1 + os.sep + filename

    if os.path.isfile(fname) or \
       os.path.isfile(fname1):
        print "File %s already exists, skipped"% fname
        return 'skipped'

    #save the data into the file
    try:
        #pass
        print data
        #f = open(fname,'wb')
        #f.write(data)
        #f.close()
    except:
        print foldername + os.sep + filename
    
    return len(data)


#########################################################
# Main func
#
foldername  = '/opt/downloads/watch/guest/wait'
foldername1 = '/opt/downloads/watch/guest'

Regexp = 'http://.*?\?t=(\d*)'
_reRegexp=re.compile(Regexp) 

if __name__ == '__main__':

    current_url = get_current_url()

    m = _reRegexp.search(current_url) 
    if m == None: 
        print 'Cannot get torrent id from ', current_url
        exit()
    
    torrent_url = 'http://dl.rutracker.org/forum/dl.php?t=' + m.group(1)

    torrent_file = get_torrent(torrent_url)
    print torrent_file

    saveURL(torrent_url)
    print 'Done: ', torrent_url


