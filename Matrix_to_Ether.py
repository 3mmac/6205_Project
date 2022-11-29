#! /usr/bin/env python

from scapy.all import *

a=sniff(count=10)
a.nsummary()