#!/bin/bash

#Use High Profile, audio passthru, embedded forced subs
#Searches for main movie on DVD's and selects all chapters from it

#check command line args
if [ -z "$1" ]; then
	echo "No command-line arguments."
else
	HandBrakeCLI  -i "$1" --main-feature -o "$1.mkv" -f mkv --strict-anamorphic  -e x264 -q 20 -a 1 -E copy -6 auto -R Auto -B auto -D 0.0 --subtitle scan --subtitle-forced=1 -x b-adapt=2:rc-lookahead=50 --verbose=1 
fi
