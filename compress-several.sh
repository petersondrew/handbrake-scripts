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
    \?)
      usage
      exit
      ;;
  esac
done

shift $(($OPTIND - 1))	

DIRECTORY=$@
if [ ! -d "$DIRECTORY" ]; then
  echo "Unknown directory" >&2
  exit
fi

FILES=$(find $DIRECTORY -type f -print0 | xargs -0 du -s | sort -nr | head -n $NUMBER | cut -f2)

compress(){
  if [ $DRYRUN ]; then
    printf "%s\n" "${FILES[@]}"
  else
    handbrake.sh "$@"
  fi
}

compress "${files[@]}"
