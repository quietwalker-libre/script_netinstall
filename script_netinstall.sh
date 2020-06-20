#!/bin/bash  

echo -e "[*] Updating the repositories"
sudo apt update -y 
echo -e "[*] Upgrading system"
sudo apt full-upgrade -y
echo "[*] Editing file /etc/sysctl.conf..."
echo vm.swappiness=10 >> /etc/sysctl.conf
echo net.ipv4.tcp_rmem = 4096 10000000 16777216 >> /etc/sysctl.conf
echo net.ipv4.tcp_wmem = 4096 65536 16777216 >> /etc/sysctl.conf
sysctl -p
echo -e "[*] Installing DE..."
sudo apt install -y curl gnome-core gnome-shell-extension-dashtodock
echo -e "[*] Downloading icons package"
curl https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1NzkxMjAyNTgiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjgwMzk5MDJjNWM1YzgxYTA0ZTY0ZTk1NDM5YjkxZTc0ZjI0YjkzOWZhYTk0OGRlZWMzOTg1NDZjZDgzYzA1Y2NiYzU1NDM4Y2M1MjhkMjczMGY2MDY1MmEyODI1ZjRmNjJhN2I5YjdmODFjNzk3MWU5MWMxNjQ0OWQ5NmNmNjcxIiwidCI6MTU5MjY0MjE4Mywic3RmcCI6IjJlN2ZhMmVjOTk0ZGJmNjEzZGNmNGYwMDViNTUwYjFhIiwic3RpcCI6IjE1MS40Ni43Mi4yMjcifQ.mSYVqvmZgXc3bQcyQrN5En6Vi7tFmu9WQt9kjo93fCI/Oranchelo.tar.xz -o oranchelo.tar.xz
tar -xvf oranchelo.tar.xz
sudo mv Oranchelo /usr/share/icons/
echo -e "[*] Installing some usefull packages"
sudo apt install -y \
                  kazam \
                  default-jdk \
                  k3b \
                  cheese \
                  vlc \
                  strace \
                  tmux \
                  vagrant \
                  htop \
                  imagemagick \
                  nmap \
                  netdiscover \
                  nload \
                  simple-scan \
                  strace \
                  wireshark \
                  kodi \
                  preload 

echo -e "[*] Adding Balena Etcher repository"
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61 
echo -e "[*] Installing Balena Etcher"
sudo apt-get update -y 
sudo apt-get install -y balena-etcher-electron
echo -e "[*] Installing KVM on the system"
sudo apt install -y \
                  qemu-kvm \
                  libvirt-clients \
                  libvirt-daemon-system \
                  bridge-utils virtinst \
                  libvirt-daemon \
                  virt-manager
echo -e "[*] Enabling autostart in KVM default network"
sudo virsh net-start default
sudo virsh net-autostart default
echo -e "[*] Doing some KVM configuration stuffs"
sudo modprobe vhost_net 
echo "vhost_net" | sudo  tee -a /etc/modules
sudo adduser $USER libvirt
sudo adduser $USER libvirt-qemu
echo -e "[*] Installing Snap Daemon"
sudo apt install -y snapd
echo -e "[*] Installing some snapd packages"
for pkg in firefox gimp keepassxc nextcloud-client onlyoffice-desktopeditors pdftk spotify telegram-desktop chromium motrix; do 
    sudo snap install $pkg; 
done 
echo -e "[*] Installing other snaps packages in classic confinement"
sudo snap install codium --classic 
echo "[*] Cleaning APT cache"
sudo apt autoremove -y
