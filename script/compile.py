#!/usr/bin/env python

from optparse import OptionParser
from glob import glob
import os
import os.path
import subprocess

def execute(command):
    proc = subprocess.Popen(
        command,
        shell = False,
        stdin  = subprocess.PIPE,
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE)
    
    stdout_data, stderr_data = proc.communicate()
    print " ".join(command);
    if stdout_data:
        print stdout_data
    if stderr_data:
        print stderr_data

op = OptionParser()
op.add_option("-I", action="append", dest="header")
op.add_option("-s", action="append", dest="stdheader")
(options, args) = op.parse_args()

if not args:
    op.error("requires keyword")
    op.print_help()
    exit()

if options.stdheader:
    os.environ["C_INCLUDE_PATH"] = ":".join(options.stdheader)
    os.environ["CPLUS_INCLUDE_PATH"] = ":".join(options.stdheader)

for path in args:
    for target in glob(os.path.join(path, "*.c")):
        command = [
            "clang", "-c", "-emit-llvm", "-Wall", "-fno-vectorize",
            target, "-o", target + ".bc"
        ]
        for header in options.header:
            command.extend(["-I", header]);

        execute(command)

    for target in glob(os.path.join(path, "*.cpp")):
        command = [
            "clang++", "-c", "-std=c++11", "-emit-llvm", "-Wall",
            "-fno-exceptions", "-fno-vectorize",
            target, "-o", target + ".bc"
        ]
        for header in options.header:
            command.extend(["-I", header]);

        execute(command)
        
    for target in glob(os.path.join(path, "*.bc")):
        command = ["/usr/local/opt/llvm/bin/llvm-dis", target]
        execute(command)
