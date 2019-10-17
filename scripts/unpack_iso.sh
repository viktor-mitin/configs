mkdir ./unpacked
mkdir ./data

mount -t auto -o ro,loop=/dev/loop0 $1 ./unpacked

cp -rv ./unpacked/* ./data

umount ./unpacked
chmod -R 777 ./data
sleep 1

