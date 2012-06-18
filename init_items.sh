#!/bin/bash
cd library
ROOT_DIR=`pwd`
for page in `ls ./*/*.html`
do
    ITEM_URL=$(cat $page | tr "\"" "\n" | egrep '^/text' | sed 's;^;http://aaaaarg.org;')
    for item in $ITEM_URL
    do
        item_dir=$ROOT_DIR/`echo $page | cut -d / -f2`/`basename $item`
        mkdir -p $item_dir
        echo -e "DOWNLOADING::\t$item_dir/`basename $item`.html"
        wget -c -O $item_dir/`basename $item`.html $item --header 'Cookie: {NAME}={CONTENT}'
    done
done
