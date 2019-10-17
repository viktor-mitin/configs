
cat soft_list.txt | while read -r line; do


	sudo apt-get install -y $line &
    wait

done < /dev/stdin


#fix gmake ubuntu issue
sudo ln -s /usr/bin/make /usr/bin/gmake

