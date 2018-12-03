#!/bin/bash -x

set -e
set -E

cd $HOME

#backup first
mv ~/.bashrc ~/.bashrc_bak
mv ~/.config/openbox/lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml_bak
mv ~/.config/lxpanel/Lubuntu/panels/panel ~/.config/lxpanel/Lubuntu/panels/panel_bak

ln -s ~/configs/.Xresources
ln -s ~/configs/.bashrc
ln -s ~/configs/.inputrc
ln -s ~/configs/.vimrc
ln -s ~/configs/lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml
ln -s ~/configs/panel ~/.config/lxpanel/Lubuntu/panels/panel
