#!/bin/sh

find .|grep .tar.gz > list.txt

for TAR in `cat list.txt`
do
    tar -xf $TAR
done