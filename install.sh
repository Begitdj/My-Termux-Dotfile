echo Hello this is install script for my termux dotfile
echo install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm -rf ~/.zshrc
cp ./.zshrc ~/.zshrc
echo install lsd
apt install lsd
echo install fonts colors extra key and p10k dotfile and zprofile and nano dotfile
rm -rf ~/.termux/termux.properties
cp ./termux.properties ~/.termux/termux.properties
rm -rf ~/.termux/color.properties
cp ./colors.properties ~/.termux/colors.properties
rm -rf ~/.termux/font.ttf
cp ./font.ttf ~/.termux/font.ttf
rm -rf ~/.p10k.zsh
cp ./.p10k.zsh ~/.p10k.zsh
rm -rf ~/.zprofile
cp ./.zprofile ~/.zprofile
rm -rf /data/data/com.termux/files/usr/etc/motd
touch /data/data/com.termux/files/usr/etc/motd
rm -rf /data/data/com.termux/files/usr/etc/profile
touch /data/data/com.termux/files/usr/etc/profile
rm -rf ~/.nanorc
cp ./.nanorc ~/.nanorc
termux-reload-settings
echo Install Complete! Full restart termux to change shell theme
