#!/bin/sh -x

set -e
set -u

move_to_bak ()
{
	mv "$1" "$1"_bak
}

cd $HOME

#backup first
move_to_bak ~/.bashrc 
move_to_bak ~/.config/openbox/lubuntu-rc.xml
move_to_bak ~/.config/lxpanel/Lubuntu/panels/panel
move_to_bak ~/.config/lxsession/Lubuntu/autostart
move_to_bak ~/.config/htop/htoprc

ln -s ~/configs/.Xresources
ln -s ~/configs/.bashrc
ln -s ~/configs/.inputrc
ln -s ~/configs/.vimrc
ln -s ~/configs/.gitconfig
ln -s ~/configs/lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml
ln -s ~/configs/panel ~/.config/lxpanel/Lubuntu/panels/panel
ln -s ~/configs/autostart ~/.config/lxsession/Lubuntu/autostart
ln -s ~/configs/htoprc ~/.config/htop/htoprc
ln -s ~/configs/muttrc ~/.mutt/muttrc
