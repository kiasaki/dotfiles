## dotfiles

## desktop install

```
ssh-keygen -t rsa -b 4096
cat ~/.ssh/id_rsa.pub | xclip -i
# add to github
sudo apt install git
mkdir ~/repos
git clone git@github.com:kiasaki/dotfiles.git ~/repos/dotfiles
cd ~/repos/dotfiles
./setup.sh
```

## server install

```
ssh-keygen -t rsa -b 4096
cat ~/.ssh/id_rsa.pub
# add to github
sudo apt install make git mosh neovim curl htop tmux jq silversearcher-ag ranger redis-server
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -qq -y neovim
git clone git@github.com:kiasaki/dotfiles.git
cd dotfiles
./setup.sh
sudo apt install postgresql
sudo -u postgres psql -c "create user $USER with superuser with login;";
sudo -u postgres psql -c "create database $USER with owner $USER;"
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update && sudo apt-get install -y kubectl
```

### wsl .env additions

```
redis-cli get test || sudo service redis-server start
psql -c 'select 1' >/dev/null || sudo service postgresql start
export DISPLAY=$(route -n | grep UG | head -n1 | awk '{print $2}'):0
```


### adding st's custom `.desktop`

```
cp support/st.desktop ~/.local/share/applications/st.desktop
```

### bump max file watches

```
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

## license

MIT
