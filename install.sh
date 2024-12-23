echo im not give you my power10k zsh theme config
apt install zsh git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
apt install lsd
echo "alias ls=lsd" >> ~/.zshrc
mkdir $HOME/.termux
cp ./colors.properties $HOME/.termux/colors.properties
cp ./font.ttf $HOME/.termux/font.ttf
echo Install Complete
