#!/bin/sh -x

#set -e
set -u

move_to_bak ()
{
	test -f $1 && mv "$1" "$1"_bak
}

cd "$HOME"

#backup first
move_to_bak ~/.bashrc
move_to_bak ~/.config/htop/htoprc

###################################################################
#### Lubuntu 18.04 and earlier
#move_to_bak ~/.config/openbox/lubuntu-rc.xml
#move_to_bak ~/.config/lxpanel/Lubuntu/panels/panel
#move_to_bak ~/.config/lxsession/Lubuntu/autostart
#ln -s ~/configs/lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml
#ln -s ~/configs/panel ~/.config/lxpanel/Lubuntu/panels/panel
#ln -s ~/configs/autostart ~/.config/lxsession/Lubuntu/autostart

#### Lubuntu 18.10 and later
move_to_bak ~/.config/openbox
move_to_bak ~/.config/lxqt
move_to_bak ~/.config/autostart

ln -f -s ~/configs/.config/openbox   ~/.config/openbox
ln -f -s ~/configs/.config/lxqt      ~/.config/lxqt
ln -f -s ~/configs/.config/autostart ~/.config/autostart
###################################################################

ln -f -s ~/configs/.Xresources .
ln -f -s ~/configs/.bashrc .
ln -f -s ~/configs/.inputrc .
ln -f -s ~/configs/.vimrc .
ln -f -s ~/configs/.gitconfig .
ln -f -s ~/configs/htoprc ~/.config/htop/htoprc
#ln -s ~/configs/muttrc ~/.mutt/muttrc
