#!/usr/bin/env python2
import os
import sys
from subprocess import Popen, PIPE
import fcntl
fileToReset  = sys.argv[-1]
USBDEVFS_RESET= 21780

try:
    f = open(fileToReset, 'w', os.O_WRONLY)
    fcntl.ioctl(f, USBDEVFS_RESET, 0)
except Exception, msg:
    print "failed to reset device:", msg
