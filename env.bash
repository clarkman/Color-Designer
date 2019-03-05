

function writeHTMLHdr
{
  if [[ -z $1 || -z $2 ]]; then
    echo "Must supply page name and file name as args: "
    echo "  writeHTMLHdr Name File"
  else
    NAME=$1
    FILE=$2

    echo "Writing header titled $NAME into file $FILE"

	echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">" > $FILE
	echo "<html>" >> $FILE
	echo "<head>" >> $FILE
	echo "<title>"$NAME"</title>" >> $FILE
	echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">" >> $FILE
	echo "</head>" >> $FILE

	echo "<body>" >> $FILE
	echo "<p><img src=\"Library/Boom.jpg\" width=\"600\" height=\"105\"></p>" >> $FILE
	echo "<p></p>"  >> $FILE
	echo "<p>""</p>" >> $FILE
	echo "<p><a href=\"Main.html\">Return to main page ...</a><br></p>" >> $FILE
	echo "<p>""</p>" >> $FILE
	echo "<p>"$NAME" Recipes</p>" >> $FILE
	echo "<p>" >> $FILE
  fi
}
export -f writeHTMLHdr


function writeHTMLFooter
{
  if [ -z $1 ]; then
    echo "Must supply file name as arg: "
    echo "  writeHTMLFooter File"
  else
    FILE=$1

    echo "Writing footer into file $FILE"

	echo "<footer>" >> $FILE
	echo "</footer>" >> $FILE
  fi
}
export -f writeHTMLFooter
