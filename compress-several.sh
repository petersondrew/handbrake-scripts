#!/bin/bash
# -h = help, -d = dry run

usage(){
cat << EOF
usage: $0 options directory

This script compresses large movies with handbrake.sh

OPTIONS:
 -h Show this message
 -d Perform dry-run, printing the files that would be compressed
 -n Number of files to compress (compresses n largest files)
EOF
}

NUMBER=20
DIRECTORY=
DRYRUN=false

while getopts "hdn:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    d) DRYRUN=true;;
    n) NUMBER=$OPTARG;;
    *)
      usage
      exit
      ;;
  esac
done

shift $(($OPTIND - 1))

DIRECTORY=$@
if [ -z "$DIRECTORY" ]; then
  echo "No directory specified" >&2
  exit
fi

if [ ! -d "$DIRECTORY" ]; then
  echo "Unknown directory" >&2
  exit
fi


FILES=$(find "$DIRECTORY" \( -iregex '.*mkv$' -o -iregex '.*avi$' -o -iregex '.*mp4$' -o -iregex '.*m4v$' -o -iregex '.*mpg$' \) -prune -o -type f -print0 | xargs -0 du -s | sort -nr | head -n $NUMBER | cut -f2)

compress(){
  oIFS="$IFS"
  IFS="
"
  _files="$@"

  if [ $DRYRUN = true ]; then
    for f in ${_files[*]}; do
      printf "File: %s\n" "$f"
    done
  else
    #echo "$@" | while read file ; do
    for f in ${_files[*]}; do
      handbrake.sh "$f"
    done
  fi

  IFS=oIFS
}

compress "$FILES"
