getNameFromNumber () {
    if [ $1 -gt 100 ]; then
        echo $1
        return
    fi
    if [ $1 -gt 10 ]; then
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
    echo "$CONTAINER_ID $fileName" > "$fileName"
    echo "$fileName"
}


SLEEP_TIME=1

cd ./shared || exit

while true
do
    createdFile=$(flock -s ".lock" -c "echo $(writeFile)")
    echo "$createdFile"
    sleep $SLEEP_TIME

    flock -s "$createdFile" -c "rm $createdFile"
    echo "removed"
    sleep $SLEEP_TIME
done
