containers=$(docker ps -q)
if [[ $containers != "" ]]; then
  echo "Removing running containers..."
  docker rm -f $containers
  echo "Running containers have been stopped and removed"
fi

rm -r ./shared/*
rm -r ./shared/.lock
echo "All files in the shared directory have been deleted"
