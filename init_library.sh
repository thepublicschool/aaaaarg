#!/bin/bash
mkdir -p library; cd library
for letter in {a..z}
do
    echo "Initializing letter: $letter"
    mkdir -p $letter; cd $letter
    wget -c -O $letter.html http://aaaaarg.org/library/$letter --header 'Cookie: SESSe93a9d750a68707d78b768b0c1df126c=26d72818bbb2888d2206c046fba6dd51' | grep -o -E "/library/$letter\w"
    grep -o -E "/library/$letter\w" $letter.html |
    sed 's;^;http://aaaaarg.org;g' |
    xargs wget --header 'Cookie: {NAME}={CONTENT}' --html-extension
    cd ..
done
