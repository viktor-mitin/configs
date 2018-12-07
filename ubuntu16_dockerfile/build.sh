#/bin/sh

docker build -t cvdi:latest .
docker run --name cc --user=c -it -v /home/c:/home/c cvdi

# docker start -ai cc

