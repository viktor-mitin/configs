#!/usr/bin/python
#
# PURPOSE: Get torrents files by given input link 
#
#

import re
import os
import sys
import urllib
import urlparse

Regexp = 'href="(http://torrents[^"]*)"'
_reRegexp=re.compile(Regexp, re.M | re.DOTALL | re.I | re.VERBOSE) 


foldername  = '/home/c/Downloads/watch/y/wait'
foldername1 = '/home/c/Downloads/watch/y'

def readURL(url):
    """Returns the file found in the URL
    """
    f = urllib.urlopen(url)
    data = f.read()
    f.close()
    return data

def saveURL(url):
    """Reads the given URL, saves the file
    """
    #get the folder name 
    folder = (urlparse.urlparse(url)[2])[1:]
    #this will have the filename too
    filename = os.path.basename(folder)
    #foldername = os.path.dirname(folder)

    #use a default filename if not given
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
        f = open(fname,'wb')
        f.write(data)
        f.close()
    except:
        print foldername + os.sep + filename
    
    return len(data)


#########################################################
# Main func
#
if __name__ == '__main__':

    #read file to value
    source = urllib.urlopen('http://thepiratebay.org/browse/506').read()
    pos=0 

    #search match in file 
    while True: 
        m = _reRegexp.search(source,pos) 
        #if this is end of the file then break
        if m == None: 
            break 

        torrent_url = m.group(1)
        print
        print torrent_url
        saveURL(torrent_url)

        pos = m.end(0) 

