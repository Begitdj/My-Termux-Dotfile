echo Hello this is install script for my termux dotfile
echo install zsh and curl and termux-api
apt install zsh curl termux-api -y
echo install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm -rf ~/.zshrc
cp ./zshrc.zsh ~/.zshrc
echo install lsd
apt install lsd
echo install fonts colors extra key and p10k dotfile
mkdir ~/.termux
echo "extra-keys = [['/','ls','$','~','UP','exit','ALT'],['ESC','CTRL','ENTER','LEFT','DOWN','RIGHT','F2']]" >> ~/.termux/termux.properties
cp ./colors.properties ~/.termux/colors.properties
cp ./font.ttf ~/.termux/font.ttf
cp ./.p10k.zsh ~/.p10k.zsh
termux-reload-settings
echo Install Complete!
