#!/usr/bin/python
# -*- coding:utf-8 -*-


import os
import zipfile

def make_dir(dir):
    if not os.path.exists(dir):
        log('make dir:%s' % dir)
        os.makedirs(dir)

def unzip_dir(zipfilename, unzipdirname):
    fullzipfilename = os.path.abspath(zipfilename)
    fullunzipdirname = os.path.abspath(unzipdirname)

    print("-------------开始解压文件-------------")

    if not os.path.exists(fullunzipdirname):
        make_dir(fullunzipdirname)
    else:
    shutil.rmtree(fullunzipdirname, ignore_errors=True)
    make_dir(fullunzipdirname)
  #Start extract files ...
    srcZip = zipfile.ZipFile(fullzipfilename, "r")
    for eachfile in srcZip.namelist():
        print "Unzip file %s ..." % eachfile
        eachfilename = os.path.normpath(os.path.join(fullunzipdirname, eachfile))
        eachdirname = os.path.dirname(eachfilename)
        if not os.path.exists(eachdirname):
            os.makedirs(eachdirname)
        fd=open(eachfilename, "wb")
        fd.write(srcZip.read(eachfile))
        fd.close()
    srcZip.close()
    print( "-----解压完成----")


def zip_dir(dirname, zipfilename):
    filelist = []
    #Check input ...
    fulldirname = os.path.abspath(dirname)
    fullzipfilename = os.path.abspath(zipfilename)
    print "Start to zip %s to %s ..." % (fulldirname, fullzipfilename)
    if not os.path.exists(fulldirname):
        print "Dir/File %s is not exist, Press any key to quit..." % fulldirname
        inputStr = raw_input()
        return
    if os.path.isdir(fullzipfilename):
        tmpbasename = os.path.basename(dirname)
        fullzipfilename = os.path.normpath(os.path.join(fullzipfilename, tmpbasename))
    if os.path.exists(fullzipfilename):
        print "%s has already exist, are you sure to modify it ? [Y/N]" % fullzipfilename
        while 1:
            inputStr = raw_input()
            if inputStr == "N" or inputStr == "n" :
                return
            else:
                if inputStr == "Y" or inputStr == "y" :
                    print "Continue to zip files..."
                    break

    #Get file(s) to zip ...
    if os.path.isfile(dirname):
        filelist.append(dirname)
        dirname = os.path.dirname(dirname)
    else:
        #get all file in directory
        for root, dirlist, files in os.walk(dirname):
            for filename in files:
                filelist.append(os.path.join(root,filename))

    #Start to zip file ...
    destZip = zipfile.ZipFile(fullzipfilename, "w")
    for eachfile in filelist:
        destfile = eachfile[len(dirname):]
        print "Zip file %s..." % destfile
        destZip.write(eachfile, destfile)
    destZip.close()
    print "Zip folder succeed!"
