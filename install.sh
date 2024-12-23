echo Installing...
apt install zsh git -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
apt install lsd
echo "alias ls=lsd" >> ~/.zshrc
mkdir $HOME/.termux
cp ./colors.properties $HOME/.termux/colors.properties
cp ./font.ttf $HOME/.termux/font.ttf
cp ./.p10k.zsh $HOME/.p10k.zsh
echo Install Complete!
