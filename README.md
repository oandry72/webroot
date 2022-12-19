# webroot

find webroot -type f -name "*.htm*" ! -name "*.en.htm*" -exec bash -c 'cp -p "$1" "${1//htm/en.htm}"' bash {} \;

find webroot -type f -name "*.htm*" ! -name "*.en.htm*" -exec rm {} \;
