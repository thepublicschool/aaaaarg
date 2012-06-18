#!/bin/bash
# Download PDF/ZIP into corresponding item dirs.
cd library
ROOT_DIR=`pwd`
for dir in `ls`
do
    AZ_DIR=$ROOT_DIR/$dir
    cd $AZ_DIR
    for item in `ls`
    do
        ITEM_DIR=$AZ_DIR/$item
        cd $ITEM_DIR
        echo -e "CREATING::\t$ITEM_DIR"
        ITEM_HTML=$ITEM_DIR/$item.html
        DURL=$(grep -o -P '(?<=\<a href\=\")http://aaaaarg\.org.*download/[0-9]{4,5}(?=\")' $ITEM_HTML)
        filename=$(echo $DURL | egrep -o '[0-9]*[0-9]' | tr "\n" "-" | sed 's/-$//g')
        wget -q -c -O $filename --header 'Cookie: {NAME}={CONTENT}' $DURL 
        ext=$(file --mime $filename | cut -d / -f2 | cut -d \; -f1)
        mv $filename $filename.$ext
        echo -e "NEWPDF::\t$ITEM_DIR/$filename.$ext"
    done
done
