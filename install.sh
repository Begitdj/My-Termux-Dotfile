echo Hello this is install script for my termux dotfile
echo install zsh and curl
apt install zsh curl -y
echo install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm -rf ~/.zshrc
echo "ZSH_THEME="powerlevel10k/powerlevel10k" >> ~/.zshrc
echo install lsd and change ls to lsd
apt install lsd
echo "alias ls=lsd" >> ~/.zshrc
echo install fonts colors and p10k dotfile
mkdir $HOME/.termux
cp ./colors.properties $HOME/.termux/colors.properties
cp ./font.ttf $HOME/.termux/font.ttf
cp ./.p10k.zsh $HOME/.p10k.zsh
echo Install Complete!
