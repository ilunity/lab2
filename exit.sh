containers=$(docker ps -q)
if [[ $containers != "" ]]; then
  echo "Removing lab2 containers..."
  docker rm -f $(docker ps -a -q --filter "ancestor=lab2")
  echo "lab2 containers have been stopped and removed"
fi

rm -r ./shared/*
rm -r ./shared/.lock
echo "All files in the shared directory have been deleted"
