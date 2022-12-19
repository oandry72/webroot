#!/usr/bin/bash

Usage(){
  echo "Usage: ./$(basename $0) [path to the webroot directory]"
  exit 1
}


if [ -z $1 ]; then
  if [ -d "webroot" ]; then
    WEBROOT="webroot"
  elif [ -d "/webroot" ]; then
    WEBROOT="/webroot"
  else
    echo "Couldn't find /webroot or webroot directory"
    Usage
  fi
else
  if [ -d "$1" ]; then
    WEBROOT=$1
  else
    echo "$1 is not a coorect webroot directory"
    Usage
  fi
fi

readarray -t ALL_FILES < <(/usr/bin/find $WEBROOT -type f ! -name "*.en.htm*" -name "*.htm*")

for FILE in "${ALL_FILES[@]}"; do
	DIR="$(dirname "${FILE}")"
	FILE_NAME="$(basename "${FILE}")"

	NEW_FILE=$(echo ${FILE_NAME} | /usr/bin/sed -e 's/\(.*\)htm/\1en.htm/g')

	echo "cp '${FILE}' '${DIR}/${NEW_FILE}'"
	/usr/bin/cp "$FILE" "$DIR/$NEW_FILE"
done


for FILE in "${ALL_FILES[@]}"; do
	/usr/bin/rm "$FILE"
done
