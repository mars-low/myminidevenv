#!/usr/bin/env bash

################ APT ################

export DEBIAN_FRONTEND=noninteractive
sudo wget -nv -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc
sudo wget -nv -O "/etc/apt/sources.list.d/xpra.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra.sources
sudo wget -nv -O "/etc/apt/sources.list.d/xpra-beta.sources" https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/xpra-beta.sources
sudo apt-get update
sudo -E apt-get -qq install -y \
acpica-tools \
adb \
alsa-oss \
alsa-utils \
alsamixergui \
apache2-utils \
apparmor \
aptitude \
apulse \
asciidoc \
asciinema \
autoconf \
bats \
bc \
binutils-aarch64-linux-gnu \
binutils-arm-linux-gnueabi \
bird \
bison \
bluez \
bluez-test-tools \
bmake \
bmon \
bubblewrap \
build-essential \
buildah \
bwm-ng \
ca-certificates \
cabextract \
cargo \
ccache \
chrpath \
clang \
clang-format \
clang-tidy \
config-package-dev \
cpio \
cppcheck \
cpu-checker \
curl \
debhelper \
debhelper-compat \
debian-keyring \
default-jdk \
desktop-file-utils \
device-tree-compiler \
devscripts \
dfu-util \
dhcping \
dkms \
dnsmasq \
dnsmasq-base \
docbook-to-man \
docbook-utils \
docbook-xsl \
doxygen \
drumstick-tools \
ebtables \
equivs \
eslint \
evtest \
f3 \
fakeroot \
firefox-esr \
flatpak \
flex \
fluid-soundfont-gm \
fluidsynth \
fontconfig \
fontforge \
fontmake \
fonttools \
fping \
freerdp2-dev \
freerdp2-x11 \
g++ \
g++-multilib \
gawk \
gcc-aarch64-linux-gnu \
gcc-arm-linux-gnueabi \
gcc-arm-none-eabi \
gcc-mingw-w64 \
gcc-multilib \
gcc-riscv64-unknown-elf \
gcovr \
gdb-multiarch \
gettext \
ghdl \
gifsicle \
gir1.2-gudev-1.0 \
git-core \
git-lfs \
glslang-dev \
glslang-tools \
gnat \
gnome-common \
gnupg \
golang \
gperf \
gsoap \
gsoap-doc \
gtk-sharp2 \
gvncviewer \
hackrf \
hdparm \
htop \
hw-probe \
icdiff \
iftop \
indent \
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
isc-dhcp-server \
iverilog \
jack-tools \
jq \
kconfig-frontends \
keyutils \
lcov \
lib32stdc++6 \
lib32z1-dev \
libacl1-dev \
libaio-dev \
libarchive-dev \
libasio-dev \
libasound2 \
libasound2-dev \
libasound2-plugins \
libass-dev \
libavcodec-dev \
libavcodec59 \
libavdevice-dev \
libavfilter-dev \
libavformat-dev \
libavutil-dev \
libavutil57 \
libboost-all-dev \
libbpf-dev \
libbrlapi-dev \
libc6-dev \
libc6-dev-arm64-cross \
libc6-dev-armel-cross \
libc6-dev-armhf-cross \
libc6-dev-i386 \
libcacard-dev \
libcairo2-dev \
libcap-dev \
libcap-ng-dev \
libcapi20-dev \
libcbor-dev \
libcgsi-gsoap-dev \
libcgsi-gsoap1 \
libcolord2 \
libconfig-dev \
libcups2-dev \
libcurl4-openssl-dev \
libdaxctl-dev \
libdbus-1-dev \
libdevmapper-dev \
libdrumstick-dev \
libdw-dev \
libegl1-mesa \
libelf-dev \
libevdev-dev \
libevent-dev \
libfaudio-dev \
libfaudio0 \
libfdt-dev \
libfmt-dev \
libfontconfig-dev \
libfreetype-dev \
libfreetype6-dev \
libftdi1-2 \
libfuse-dev \
libfuse3-dev \
libgcrypt20-dev \
libgflags-dev \
libgif-dev \
libgl-dev \
libgl1-mesa-dev \
libglu1-mesa-dev \
libgnutls28-dev \
libgoogle-glog-dev \
libgphoto2-dev \
libgpiod2 \
libgsm1-dev \
libgstreamer-plugins-base1.0-dev \
libgstreamer1.0-dev \
libgtest-dev \
libgtk-3-bin \
libgtk-3-dev \
libgtk2.0-0 \
libgudev-1.0-dev \
libguestfs-tools \
libgvnc-1.0-dev \
libhidapi-hidraw0 \
libhidapi-libusb0 \
libiberty-dev \
libidl-dev \
libinput-dev \
libiscsi-dev \
libisl-dev \
libjaylink0 \
libjim0.81 \
libjpeg62-turbo-dev \
libjson-c-dev \
libjsoncpp-dev \
libkdb5-10 \
libkeyutils-dev \
libkrb5-dev \
liblcms2-dev \
libldap2-dev \
liblttng-ust-dev \
liblua5.3-dev \
liblz4-dev \
liblzf-dev \
liblzo2-dev \
libmp3lame-dev \
libmpc-dev \
libmpfr-dev \
libmpg123-dev \
libncurses5 \
libncurses5-dev \
libncursesw5 \
libnfs-dev \
libnotify-dev \
libopenal-dev \
libopenblas-dev \
libopenblas-pthread-dev \
libopenblas0 \
libopenblas0-pthread \
libopus-dev \
libosmesa6-dev \
libpam0g-dev \
libpango1.0-dev \
libpcap-dev \
libpci-dev \
libpmem-dev \
libpmem2-dev \
libpng-dev \
libpostproc-dev \
libppl14 \
libprotobuf-c-dev \
libpulse-dev \
libqt5opengl5-dev \
libqt5scxml5 \
libqt5scxml5-bin \
libqt5scxml5-private-dev \
libqt5x11extras5-dev \
libqt6bluetooth6 \
libqt6bluetooth6-bin \
libqt6datavisualization6 \
libqt6help6 \
libqt6jsonrpc6 \
libqt6languageserver6 \
libqt6nfc6 \
libqt6qmlcompiler6 \
libqt6qmlworkerscript6 \
libqt6quickcontrols2-6 \
libqt6quickshapes6 \
libqt6quicktest6 \
libqt6scxml6 \
libqt6scxml6-bin \
libqt6statemachine6 \
libqt6svg6 \
libqt6waylandclient6 \
libqt6waylandcompositor6 \
librbd-dev \
librsvg2-bin \
libsane-dev \
libsasl2-dev \
libsdl-ttf2.0-dev \
libsdl1.2-dev \
libsdl2-dev \
libseccomp-dev \
libsecret-1-dev \
libslirp-dev \
libsnappy-dev \
libspice-protocol-dev \
libspice-server-dev \
libssh-dev \
libssh2-1-dev \
libssl-dev \
libstdc++5 \
libswresample-dev \
libswresample4 \
libswscale-dev \
libsysprof-4-dev \
libsystemd-dev \
libtelnet-dev \
libtiff5-dev \
libtool-bin \
libtpms-dev \
libu2f-host-dev \
libu2f-server-dev \
libudev-dev \
libunwind-dev \
liburing-dev \
libusb-1.0-0-dev \
libusbredirparser-dev \
libv4l-dev \
libva-dev \
libvdeplug-dev \
libvdpau-dev \
libvirglrenderer-dev \
libvirt-clients \
libvirt-daemon-system \
libvirt-dev \
libvkd3d-dev \
libvncserver-dev \
libvorbis-dev \
libvpx-dev \
libvulkan-dev \
libvulkan1 \
libwayland-bin \
libwayland-dev \
libwebkit2gtk-4.0-37 \
libwebp-dev \
libwebsockets-dev \
libwnck-3-dev \
libx11-dev \
libxapian30 \
libxcb-shape0-dev \
libxcb-xfixes0-dev \
libxcomposite-dev \
libxcursor-dev \
libxext-dev \
libxfixes-dev \
libxi-dev \
libxinerama-dev \
libxkbfile-dev \
libxml2-dev \
libxml2-utils \
libxmu-dev \
libxrandr-dev \
libxrender-dev \
libxslt-dev \
libxslt1-dev \
libxt-dev \
linux-libc-dev \
linux-libc-dev-armel-cross \
linux-perf \
lld-14 \
locales \
lshw \
ltrace \
lz4 \
lzma \
m4 \
make \
makeself \
mercurial \
mesa-common-dev \
meson \
mingw-w64 \
minicom \
mono-complete \
mosquitto \
mosquitto-clients \
mpv \
mtools \
mtp-tools \
mtr \
nasm \
ncurses-dev \
neofetch \
net-tools \
netcat-openbsd \
nethogs \
nettle-bin \
network-manager \
nftables \
ngrep \
ninja-build \
nmap \
novnc \
nxagent \
ocl-icd-opencl-dev \
openocd \
packaging-dev \
pandoc \
passt \
patchelf \
picocom \
pipewire \
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
python3-dev \
python3-git \
python3-jinja2 \
python3-ldb \
python3-pefile \
python3-pexpect \
python3-pip \
python3-proselint \
python3-pyside2.qtscxml \
python3-serial \
python3-sphinx \
python3-subunit \
python3-tk \
python3-tomli \
qemu-kvm \
qemu-system-common \
qemu-utils \
qjackctl \
qml6-module-qtscxml \
qsynth \
qt6-5compat-dev \
qt6-base-dev \
qt6-base-private-dev \
qt6-connectivity-dev \
qt6-datavisualization-dev \
qt6-declarative-dev \
qt6-scxml-dev \
qt6-tools-dev \
qt6-tools-dev-tools \
qt6-tools-private-dev \
qt6-wayland \
qt6-wayland-dev-tools \
qt6ct \
qtscxml5-doc \
qtscxml5-doc-html \
qtscxml5-examples \
qttools5-dev \
qttools5-dev-tools \
r-base \
r-base-dev \
rlwrap \
rpm \
rsyslog \
rubocop \
ruby-dev \
ruby-libvirt \
rustc \
samba-dev \
samba-libs \
schedtool \
scons \
screen \
sg3-utils \
sharutils \
slurm \
sndio-tools \
socat \
sox \
sparse \
spell \
spice-html5 \
spice-vdagent \
spice-webdavd \
srecord \
stress \
subversion \
sysfsutils \
sysprof \
tasksel \
tcpdump \
tcptrack \
telnet \
texinfo \
texlive \
texlive-fonts-extra \
texlive-latex-extra \
tftpd-hpa \
tightvncserver \
time \
tio \
traceroute \
tshark \
tzdata \
u-boot-tools \
u2f-host \
u2f-server \
ufw \
uml-utilities \
uncrustify \
universal-ctags \
unixodbc-dev \
unzip \
usbip \
usbredirect \
usbutils \
uuid-dev \
v4l-utils \
valgrind \
virgl-server \
virt-manager \
wget \
whiptail \
whois \
wildmidi \
wireplumber \
x11proto-core-dev \
xclip \
xen-hypervisor-amd64 \
xen-tools \
xfce4 \
xfce4-goodies \
xinput \
xorg-dev \
xpra \
xrdp \
xserver-xorg-dev \
xsltproc \
xterm \
xutils-dev \
xvfb \
yasm \
yoshimi \
zenity \
zip \
zlib1g-dev \
&& sudo apt-get clean -y && sudo rm -rf /var/lib/apt/lists/*

################ DEB ################

TEMP_DEB="$(mktemp)" \
&& wget -nv -O "$TEMP_DEB" 'https://github.com/coder/code-server/releases/download/v4.96.2/code-server_4.96.2_amd64.deb' \
&& sudo dpkg -i "$TEMP_DEB" \
&& rm -f "$TEMP_DEB"

TEMP_DEB="$(mktemp)" \
&& wget -nv -O "$TEMP_DEB" 'https://releases.hashicorp.com/vagrant/2.3.7/vagrant_2.3.7-1_amd64.deb' \
&& sudo dpkg -i "$TEMP_DEB" \
&& rm -f "$TEMP_DEB"

################ SRC ################

TEMP_TAR_GZ="$(mktemp)" \
TEMP_DIR="$(mktemp -d)" \
&& wget -nv -O "$TEMP_TAR_GZ" 'https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz' \
&& tar -zxf "$TEMP_TAR_GZ" -C "$TEMP_DIR" \
&& cd "${TEMP_DIR}/tmux-3.5a" \
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
