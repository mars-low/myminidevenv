#!/usr/bin/env bash

################ APT ################

# you will be asked interactively about keyboard layot, jackd, wireshark (how to remove it and say yes to everything?)

export DEBIAN_FRONTEND=noninteractive
sudo wget -nv -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc
sudo wget -nv -O "/etc/apt/sources.list.d/xpra.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra.sources
sudo wget -nv -O "/etc/apt/sources.list.d/xpra-beta.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra-beta.sources
sudo apt-get update
sudo apt-get -qq install \
acpica-tools \
adb \
alsa-oss \
alsa-utils \
alsamixergui \
apache2-utils \
apparmor \
apulse \
asciidoc \
asciinema \
bc \
bird \
bison \
bluez \
bluez-test-tools \
bmon \
bubblewrap \
build-essential \
bwm-ng \
ca-certificates \
cabextract \
clang \
clang-tidy \
config-package-dev \
cpio \
cppcheck \
cpu-checker \
curl \
debhelper-compat \
debian-keyring \
device-tree-compiler \
devscripts \
devscripts \
dfu-util \
dhcping \
dnsmasq \
dnsmasq-base \
doxygen \
drumstick-tools \
ebtables \
equivs \
eslint \
evtest \
evtest \
f3 \
fakeroot \
flatpak \
flex \
fluid-soundfont-gm \
fluidsynth \
fontconfig \
fping \
freerdp2-x11 \
g++ \
gcc-aarch64-linux-gnu \
gcc-arm-none-eabi \
gcovr \
gdb-multiarch \
gettext \
ghdl \
gifsicle \
git-core \
git-lfs \
glslang-tools \
gnat \
gnupg \
golang \
gperf \
gtk-sharp2 \
gvncviewer \
hackrf \
hdparm \
htop \
hw-probe \
iftop \
ikaruss \
inxi \
iperf \
iperf3 \
iproute2 \
ipset \
iptables \
iptraf-ng \
iputils-ping \
ipvsadm \
isc-dhcp-client \
iverilog \
jack-tools \
kconfig-frontends \
lib32z1-dev \
libasio-dev \
libasound2 \
libasound2-plugins \
libc6-dev \
libc6-dev-i386 \
libdrumstick-dev \
libelf-dev \
libevent-dev \
libfmt-dev \
libftdi1-2 \
libfuse-dev \
libgflags-dev \
libgl1-mesa-dev \
libgoogle-glog-dev \
libgpiod2 \
libgtest-dev \
libgtk-3-bin \
libgtk-3-dev \
libgtk2.0-0 \
libhidapi-hidraw0 \
libhidapi-libusb0 \
libisl-dev \
libjaylink0 \
libjim0.81 \
libjsoncpp-dev \
libkrb5-dev \
libmpfr-dev \
libncurses5 \
libncurses5-dev \
libncursesw5 \
libnotify-dev \
libprotobuf-c-dev \
librsvg2-bin \
libsecret-1-dev \
libslirp-dev \
libssl-dev \
libudev-dev \
libusb-1.0-0-dev \
libvirt-clients \
libvirt-daemon-system \
libvirt-dev \
libwebkit2gtk-4.0-37 \
libx11-dev \
libxapian30 \
libxkbfile-dev \
libxml2-dev \
libxml2-utils \
libxslt-dev \
linux-perf \
locales \
lshw \
ltrace \
lzma \
m4 \
mercurial \
minicom \
mono-complete \
mosquitto \
mosquitto-clients \
mpv \
mtools \
mtr \
ncurses-dev \
neofetch \
net-tools \
netcat-openbsd \
nethogs \
network-manager \
nftables \
ngrep \
ninja-build \
nmap \
novnc \
nxagent \
openocd \
packaging-dev \
pandoc \
patchelf \
picocom \
pipewire-audio \
pipewire-audio-client-libraries \
pipewire-libcamera \
pipewire-v4l2 \
pkg-config \
playmidi \
policykit-1 \
procps \
protobuf-c-compiler \
pulseaudio-utils \
python-is-python3 \
python3-pip \
python3-proselint \
python3-serial \
python3-sphinx \
qemu-kvm \
qemu-system-common \
qemu-utils \
qjackctl \
qsynth \
qt6-5compat-dev \
qt6-base-dev \
qt6-tools-dev \
r-base \
r-base-dev \
rlwrap \
rpm \
rubocop \
ruby-dev \
ruby-libvirt \
scons \
screen \
sg3-utils \
slurm \
socat \
sox \
spell \
srecord \
stress \
sysfsutils \
sysprof \
tcpdump \
tcptrack \
telnet \
texinfo \
texlive \
tightvncserver \
tio \
traceroute \
tshark \
tzdata \
u-boot-tools \
uml-utilities \
uncrustify \
universal-ctags \
unzip \
usbip \
usbutils \
v4l-utils \
virt-manager \
whiptail \
wildmidi \
wireplumber \
x11proto-core-dev \
xfce4 \
xfce4-goodies \
xinput \
xorg-dev \
xpra \
xsltproc \
xterm \
xutils-dev \
xvfb \
yoshimi \
zip \
zlib1g-dev \
&& sudo apt-get clean -y && sudo rm -rf /var/lib/apt/lists/*

################ DEB ################

TEMP_DEB="$(mktemp)" \
&& wget -nv -O "$TEMP_DEB" 'https://github.com/coder/code-server/releases/download/v4.92.2-rc.1/code-server_4.92.2-rc.1_amd64.deb' \
&& sudo dpkg -i "$TEMP_DEB" \
&& rm -f "$TEMP_DEB"

TEMP_DEB="$(mktemp)" \
&& wget -nv -O "$TEMP_DEB" 'https://releases.hashicorp.com/vagrant/2.3.7/vagrant_2.3.7-1_amd64.deb' \
&& sudo dpkg -i "$TEMP_DEB" \
&& rm -f "$TEMP_DEB"

################ SRC ################

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/tmux/tmux/releases/download/3.4/tmux-3.4.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& cd "${TEMP_DIR}/tmux-3.4" \
&& ./configure \
&& make \
&& sudo make install \
&& cd - \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/jonas/tig/releases/download/tig-2.5.9/tig-2.5.9.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& cd "${TEMP_DIR}/tig-2.5.9" \
&& make prefix=/usr/local \
&& sudo make install prefix=/usr/local \
&& cd - \
&& rm -rf "$TEMP_TAR_GZ" "$TEMP_DIR"

TEMP_TBZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TBZ" 'https://github.com/aristocratos/btop/releases/download/v1.3.2/btop-x86_64-linux-musl.tbz' \
&& tar xvfj "$TEMP_TBZ" -C "$TEMP_DIR" \
&& cd "${TEMP_DIR}/btop" \
&& sudo make install \
&& sudo make setuid \
&& cd - \
&& rm -rf "$TEMP_TBZ" "$TEMP_DIR"
