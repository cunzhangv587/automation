#obbler for Kickstart Configurator for CentOS 7.1 by cunzhang
install
url --url=$tree  
text
lang en_US.UTF-8
keyboard us
zerombr
bootloader --location=mbr 
# Network information
$SNIPPET('network_config')
timezone --utc Asia/Shanghai
authconfig --enableshadow --passalgo=sha512
rootpw  --iscrypted $default_password_crypted
clearpart --all --initlabel
part /boot --fstype xfs --size 500  
part swap --size 2000
part / --fstype xfs --size 15000 
firstboot --disable
selinux --disabled
firewall --disabled
logging --level=info
reboot
%pre
$SNIPPET('log_ks_pre')
$SNIPPET('kickstart_start')
$SNIPPET('pre_install_network_config')
# Enable installation monitoring
$SNIPPET('pre_anamon')
%end
%packages
@base
@compat-libraries
@debugging
@development
tree
nmap
sysstat
lrzsz
dos2unix
telnet
iptraf
ncurses-devel
net-tools
openssl-devel
zlib-devel
OpenIPMI-tools
screen
%end
%post
systemctl disable postfix.service
%end
