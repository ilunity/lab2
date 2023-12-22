getNameFromNumber () {
    if [ $1 -gt 99 ]; then
        echo $1
        return
    fi
    if [ $1 -gt 9 ]; then
        echo "0$1"
        return
    fi

    echo "00$1"
}

getFreeName () {
    counter=1

    while [[ -f $(getNameFromNumber $counter) ]]
    do
        (( ++counter ))
    done

    echo "$(getNameFromNumber $counter)"
}

writeFile () {
    fileName=$(getFreeName)
    echo "$HOSTNAME $fileName" > "$fileName"
    echo "$fileName"
}

SLEEP_TIME=1

cd ./shared || exit

while true
do
    exec 9>>lock
    flock -s 9 || exit
    fileName=$(writeFile)
    exec 9<&-

    if [ -n "$fileName" ]; then
      echo "$fileName created"
      sleep $SLEEP_TIME
      rm $fileName
      echo "$fileName removed"
      fileName=""
    fi

    sleep $SLEEP_TIME
done
