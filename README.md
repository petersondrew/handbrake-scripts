handbrake.sh
============

Description
-----------
Compresses the specified video file using high profile h.264 encoding, strict anamorphic, audio passthrough, and automatic embedded forced subtitles.

Compatibility
-------------
Tested on DVD ISO images and M2TS containers. When compressing a DVD the main movie file will be automatically discovered.

Usage
-----
handbrake.sh filename

compress-several.sh
===================

Description
-----------
Compresses the n largest files in the specified directory (recursive find) using the handbrake.sh script.

Usage
-----
compress-several.sh options directory  
Options:  
  -h Show this message  
  -d Perform dry-run, printing the files that would be compressed  
  -n Number of files to compress (compresses n largest files) 

[![endorse](http://api.coderwall.com/petersondrew/endorsecount.png)](http://coderwall.com/petersondrew) 
