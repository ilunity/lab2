[[ $1 -ne "" ]] && n=$1 || n=1

for i in $(seq 1 $n)
do
    docker run -v "$(pwd)/shared":/shared -tid lab2
done
