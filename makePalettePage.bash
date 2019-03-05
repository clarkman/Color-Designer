#!/bin/sh

# Copyright 2008, Clark Dunson

# List directory files into an HTML page


source env.bash

IN_TYPE=$1
OUT_PAGE=$IN_TYPE.html
OUT_TMP=$OUT_PAGE.tmp
OUT_MATCH=$OUT_PAGE.sort.tmp


rm -f $OUT_MATCH
rm -f $OUT_TMP

DIR="palettes"
PALETTES=`ls $DIR`

echo $PALETTES

PAGE_TITLE="Color Palettes"
echo ""
echo "Making $PAGE_TITLE html page."

writeHTMLHdr "$PAGE_TITLE" $OUT_PAGE

# Form
# <a href="Dana/barbequed fillets.jpg">barbequed fillets</a><br>

for AUTH_DIR in $AUTH_DIRS
do
    find $AUTH_DIR -type f -name \*.jpg | sed 's/\.jpg//g' | awk -F/ '{print "<a href=\""$0".jpg\">"$3"</a><br>"}' >> $OUT_TMP
done


if [ $1 = "Index" ]
then
    cat $OUT_TMP | awk -F\> '{print $2"SSSS"$1}' | sort -u | awk -FSSSS '{print $2">"$1"><br>"}' >> $OUT_PAGE
else
    for params
    do  
        while read FULL_PATH
        do
          RECIPE=$(echo $FULL_PATH | awk -F\> '{print $2}' | awk -F\< '{print $1}' )
          if echo $RECIPE | grep -i $params > /dev/null
          then
            echo "Added " $RECIPE
            echo $FULL_PATH >> $OUT_MATCH
          fi
        done < $OUT_TMP
    done
    
    cat $OUT_MATCH | awk -F\> '{print $2"SSSS"$1}' | sort -u | awk -FSSSS '{print $2">"$1"><br>"}' >> $OUT_PAGE
fi

echo "</p>" >> $OUT_PAGE
echo "</body>" >> $OUT_PAGE

writeHTMLFooter $OUT_PAGE

rm -f $OUT_MATCH
rm -f $OUT_TMP

