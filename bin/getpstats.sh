#!/usr/bin/env bash

FILENAME=`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32`
#wget -O - -o /dev/null $1 > $FILENAME
cp pp1501.zip $FILENAME
7z e -p$2 -bd -so $FILENAME
rm $FILENAME
