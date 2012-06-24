#!/bin/bash

if [[ ! -n $1 ]]
then
    echo "One argument required, filename ending in .html to process"
    exit 1
fi

base=`basename $1 .html`
echo -n "document.write('" > ${base}.js
perl -p -e 's/\n/<br\/>/' < ${base}.html >> ${base}.js
echo "');" >> ${base}.js