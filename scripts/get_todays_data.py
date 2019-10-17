#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# PURPOSE: parse today toprealty database 
#
#

import re
import os
import sys
import urllib
import pickle

from pprint import pprint

tr_regexp = '''<tr.*?title='(.*?)'> #title
               \s*<td.*?>(.*?)</td>\s*    #2 type
               \s*<td.*?>(.*?)</td>\s*    #3 num of rooms
               \s*<td.*?>(.*?)</td>\s*    #4 region
               \s*<td.*?>(.*?)</td>\s*    #5 description
               \s*<td.*?>(.*?)</td>\s*    #6 flour
               \s*<td.*?>(.*?)</td>\s*    #7 area common
               \s*<td.*?>(.*?)</td>\s*    #8 area live
               \s*<td.*?>(.*?)</td>\s*    #9 area kitchen
               \s*<td.*?>(.*?)</td>\s*    #10 city phone
               \s*<td.*?>(.*?)</td>\s*    #11 cost
               \s*<td.*?>(.*?)</td>\s*    #12 phone num
               \s*<td.*?>(.*?)</td>\s*    #13 date
               \s*<td.*?>(.*?)</td>\s*    #14 type 
               .*?</tr>'''

tr_only = '''<tr.*?title='(.*?)'> #title
               .*?</tr>'''
_reTr=re.compile(tr_regexp, re.M | re.DOTALL | re.I | re.VERBOSE) 
_reTrOnly=re.compile(tr_only, re.M | re.DOTALL | re.I | re.VERBOSE) 

#########################################################
# parse table
#
def parse(data):
    result = dict()

    pos=0 
    count = 0
    while True: 
        m = _reTr.search(data,pos) 
        if m == None: 
            break 
        count += 1
        one_str = m.group(0)
        pos = m.end(0) 

        key = m.group(5)
        
        result[key] = dict()
        result[key]['one_str'] = m.group(0)
        result[key]['title'] = m.group(1)
        result[key]['description'] = m.group(5)
        result[key]['city_phone'] = m.group(10)
        result[key]['price'] = m.group(11)
        result[key]['date'] = m.group(13)
        result[key]['phone_num'] = m.group(12)

    #print count
    #pprint(result)
    return result


#########################################################
# filter data
#
exceptions = ('ИАН', 'агенство', 'Агенство', 'АГЕНСТВО', 'Aген',)
def filter(data):

    phone_nums = dict()

    total_appended_to_filter = 0
    for key, value in data.items():
        #check for complains first
        if 'complain' in value['description']:
            if value['phone_num'] not in phone_filter_list:
                phone_filter_list.append(value['phone_num'])
                total_appended_to_filter += 1

        '''
        if int(value['price']) > 380:
            if value['phone_num'] not in phone_filter_list:
                phone_filter_list.append(value['phone_num'])
                total_appended_to_filter += 1
        '''

        #check for forbidden words
        for word in exceptions:
            if word in value['title']:
                if value['phone_num'] not in phone_filter_list:
                    phone_filter_list.append(value['phone_num'])
                    total_appended_to_filter += 1

        #search duplicated phone numbers
        if value['phone_num'] not in phone_nums:
            phone_nums[value['phone_num']] = 1
        else:
            phone_nums[value['phone_num']] += 1

    #put duplicated phone numbers to filter list
    for phone in phone_nums:
        if phone_nums[phone] > 1:
            if value['phone_num'] not in phone_filter_list:
                phone_filter_list.append(value['phone_num'])
                total_appended_to_filter += 1


    total_removed = 0
    for key in data.keys():
        if data[key]['phone_num'] in phone_filter_list:
            del data[key]
            total_removed += 1

    #save filter list to file
    f = open(fname, 'wb')
    pickle.dump(phone_filter_list, f)
    f.close()

    #print phone_filter_list
    print 'total removed: ', total_removed
    print 'total appended_to_filter: ', total_appended_to_filter
    print 'total last run: ', len(data)

#########################################################
# parse table
#
def save_log(data, fname):
    dates = list()
    for key in data:
         dates.append(data[key]['date'])
    dates.sort()

    f = open(fname, 'w')
    for key in data:
        for date in dates:
            if data[key]['date'] == date:
                f.write( '----------------------------------------------------------------\n',)
                f.write( date)
                f.write( '\n        ',)
                f.write( data[key]['description'] )
                f.write( '\n        ',)
                f.write( data[key]['price'])
                f.write( '\n        ',)
                f.write( data[key]['phone_num'])
                f.write( '\n        ',)
                f.write( data[key]['title'] )
                f.write( '\n',)

#########################################################
# Main func
#
Regexp = '<tbody>\s*<\s*tr.*?</tbody>'
_reRegexp=re.compile(Regexp, re.M | re.DOTALL | re.I) 

if __name__ == '__main__':

    #read file to value
    #source = urllib.urlopen('http://toprealty.org.ua/?type=rent&object_type=%CA%E2%E0%F0%F2%E8%F0%F3&rayon=%C3%EE%EB%EE%F1%E5%E5%E2%F1%EA%E8%E9&fl_rooms=1&fl_price_from=&fl_price_to=&filterdays=2&action=filter&Submit=%CD%E0%E9%F2%E8%21&q=&direct=1').read()

    source = urllib.urlopen('http://toprealty.org.ua/?type=rent&object_type=%CA%EE%EC%ED%E0%F2%F3&rayon=%C3%EE%EB%EE%F1%E5%E5%E2%F1%EA%E8%E9&fl_rooms=1&fl_price_from=&fl_price_to=&filterdays=2&action=filter&Submit=%CD%E0%E9%F2%E8%21&q=&direct=1').read()

    #search match in file 
    m = _reRegexp.search(source) 
    #if this is end of the file then break
    if m == None: 
        print "not found"
    all_data = m.group(0)
    all_data = all_data.decode('CP1251')

    all_data = all_data.encode('utf-8')

    result_dict = parse(all_data)

    fname = 'filter_list.pkl'
    try:
        f = open(fname, 'r')
        phone_filter_list = pickle.load(f)
    except IOError:
        phone_filter_list = list()
        f = open(fname, 'wb')
        pickle.dump(phone_filter_list, f)
    f.close()

    filter(result_dict)
    save_log(result_dict, 'data.log')

    #print all_data

