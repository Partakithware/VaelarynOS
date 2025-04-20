# VaelarynOS
OS-CodexOperatum

Made with intentions to be used after installing Ubuntu 24.04, This will set up the environment to my preferences.
Prepares many things, gets you setup to use Nemo over Thunar/Nautilus/Baobab which ubuntu comes with.
Removes Firefox and replaces with Thorium. (Just to start off) 
Prepares Proton and sets you up to be able to double-click run EXE and MSI as if native.
Removes AppCenter and installs a flathub store.
Etc.

This is a personal quick-start project for myself, it was setup rather quickly before I did a fresh install of Ubuntu and requires a bit of manual configuration afterward and beforehand for each element to work as intended.
For instance the .desktop files need to be set as allowed to run as programs else failure, the proton build is installed by making sure all the related .sh are set to be allowed to run as program, then you have to run proton_g_init.sh followed by installer_2.sh and nothing else for proton. I use edge not thorium as I don't quite trust thorium. So I decided against it but left the .sh. The flathub store script seemed to be broken so I manually opened it and installed fuse,fuse3,flatpak,gnome-terminal, and the line to setup flathub, then I had to modify the .desktop file to run it with --no-sandbox else it fails to run. I forgot to upload my icons script...so irrelevant I guess.

Anyhow I suppose the most useful files you could get from this if you come across it, are installer_2.sh and every .sh proton script as with those you can achieve a double click install and run of exe and msi files. Although you will need to create a folder named "Windows" in your home directory as well.
