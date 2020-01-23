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

ln -s ~/configs/.config/openbox   ~/.config/openbox
ln -s ~/configs/.config/lxqt      ~/.config/lxqt
ln -s ~/configs/.config/autostart ~/.config/autostart
###################################################################

ln -s ~/configs/.Xresources .
ln -s ~/configs/.bashrc .
ln -s ~/configs/.inputrc .
ln -s ~/configs/.vimrc .
ln -s ~/configs/.gitconfig .
ln -s ~/configs/htoprc ~/.config/htop/htoprc
#ln -s ~/configs/muttrc ~/.mutt/muttrc
