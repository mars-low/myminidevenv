# Host setup

Start from the clean debian-12 install (https://www.debian.org/download).
Add the user to sudoers group by editing _/etc/sudoers_ file:

```sh
su root
sudo nano /etc/sudoers
```

 For example if your user is _codespace_:

```txt
codespace ALL=(ALL:ALL) ALL
```

Generate two ssh keys - first will be used for your regular actions and the second one (_rsa_) for VM SSH connection.
Follow the steps in https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Register generated keys to `ssh-agent`:

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/id_rsa
```

Add key to your Github account (https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) and check connection:

```sh
ssh -T git@github.com
```

Mount external disk:

```sh
sudo mkdir /vm-storage
sudo mount /dev/sda1 /vm-storage
```

Follow the steps in [virt-lightning](https://github.com/virt-lightning/virt-lightning/blob/2.3.2/README.md#installation-debianubuntu)
to install minimal dependencies:

```sh
sudo apt install python3-libvirt qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst libvirt-daemon genisoimage cpu-checker tmux
sudo apt install python3-venv pkg-config gcc libvirt-dev python3-dev pipx
pipx ensurepath
pipx install virt-lightning
pipx install --include-deps ansible
```

Add user to _libvirt_ group:

```sh
sudo adduser $USER libvirt
```

Check you have `kvm` virtualization enabled:

```sh

$ sudo kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used
```

# VM setup

Run `vl storage_dir`, that will print you next steps similar to the ones below:

```sh
sudo mkdir -p /var/lib/virt-lightning/pool/upstream
sudo chown -R libvirt-qemu:libvirt-qemu /var/lib/virt-lightning/pool
sudo chown -R $USER /var/lib/virt-lightning/pool/upstream
sudo chmod 775 /var/lib/virt-lightning
sudo chmod 775 /var/lib/virt-lightning/pool /var/lib/virt-lightning/pool/upstream
```

Download a generic cloud image for `debian-12` distro.
There are many available distros, but all steps below assume you chose `debian-12`.

```sh
vl fetch debian-12
```

Create directory, where you will store your VM's configuration:

```sh
mkdir minivm && cd minivm
```

You can generate default configuration with the `vl distro_list` command
and customize it to your needs like in [virt-lightning.yaml](https://gist.github.com/mars-low/4100771a7514d52dc811cce23f088167#file-virt-lightning-yaml).

```sh
vl distro_list > virt-lightning.yaml
```

Create and start VM declared in `virt-lightning.yaml`:

```sh
vl up
```

Generate an inventory for Ansible and execute a [playbook.yml](https://gist.github.com/mars-low/4100771a7514d52dc811cce23f088167#file-virt-lightning-yaml) inside VM:

```sh
vl ansible_inventory > inventory
ansible-playbook -i inventory playbook.yml
```

Log to VM using ssh:

```sh
ssh -F $( vl ssh_config > .ssh_config | echo .ssh_config) debian-12
```

You can use `virsh` to maintain VM:

```sh
virsh -c qemu:///system edit --domain debian-12 # edit libvirt xml

# To reload/reboot VM, run two commands:
virsh -c qemu:///system destroy debian-12
virsh -c qemu:///system start debian-12
```

You can learn how to share a host directory with a guest using [Virtiofs](https://libvirt.org/kbase/virtiofs.html#sharing-a-host-directory-with-a-guest)
or [NFS](https://libvirt.org/storage.html#network-filesystem-pool). Be aware that Virtiofs and NFS may cause problems
during file-intensive operations like building a Chromium browser or Android kernel.

The most reliable way to add persistant storage is to hot-plug hard drive to VM.

On host find an unmounted partition using `lsblk` command:

```sh
$ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    0 931.5G  0 disk
└─sda1        8:1    0 931.5G  0 part
nvme0n1     259:0    0 232.9G  0 disk
├─nvme0n1p1 259:1    0   512M  0 part /boot/efi
├─nvme0n1p2 259:2    0 231.4G  0 part /
└─nvme0n1p3 259:3    0   977M  0 part [SWAP
```

Attach `sda1` partition to VM:

```sh
virsh -c qemu:///system attach-disk debian-12 /dev/sda1 vdc
```

Command above mounts `/dev/sda1` as `vdc`, but it shows up as `/dev/vdb` inside VM (not sure why).
Therefore you use `/dev/vdb` as a hint to `mount` command after logging to VM
(`ssh -F $( vl ssh_config > .ssh_config | echo .ssh_config) debian-12`):

```sh
sudo mkdir /vm-storage
sudo mount /dev/vdb /vm-storage
```

To use the drive again on the host,
detach it from VM and mount on the host as usual with a similar command to the one above:

```sh
virsh -c qemu:///system detach-disk debian-12 vdc # it shows as vdb inside VM but we used vdc during attach-disk
```

# Container setup

We use a rootfull (not rootless) podman to run containers in privileged mode.
Fetch a prebuilt image from https://github.com/mars-low/devcontainer.

```sh
sudo podman pull ghcr.io/mars-low/devcontainer:latest
```

It downloads ~10GB so it's recommended to save it locally
to avoid multiple downloads in the case VM is destroyed and recreated:

```sh
sudo podman image save --quiet -o /vm-storage/ghcr.io_mars-low_devcontainer.tar ghcr.io/mars-low/devcontainer # save an image to local archive
sudo podman load -i /vm-storage/ghcr.io_mars-low_devcontainer.tar # load an image from local archive
```

Create and start container:

```sh
sudo podman run -ti -d \
--name "dev_codespace" \
--cap-add=all \
--net=host --security-opt seccomp=unconfined \
--privileged --init \
--user codespace \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock \
-v /var/run/libvirt/virtlogd-sock:/var/run/libvirt/virtlogd-sock \
-v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
-v /lib/modules:/lib/modules \
-v /dev:/dev \
-v /vm-storage:/vm-storage \
ghcr.io/mars-low/devcontainer:latest /bin/bash
```
Attach to the running container:

```sh
sudo podman container attach dev_codespace
```

Setup container on the first use (default _$USER_ is _codespace_):

```sh
sudo ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
sudo dpkg-reconfigure -f noninteractive tzdata
sudo chsh -s /bin/zsh $USER
sudo passwd $USER # interactive, set password for ssh access
```

Now install all **system** packages from apt, or built from source.
Take a look at [codespace_setup.sh](https://gist.github.com/mars-low/4100771a7514d52dc811cce23f088167#file-codespace-setup-sh).

Add user to groups:

```sh
sudo adduser $USER kvm
sudo adduser $USER video
sudo adduser $USER audio
sudo adduser $USER dialout
sudo adduser $USER plugdev
sudo adduser $USER render
sudo adduser $USER pipewire # created after installing pipewire
sudo adduser $USER libvirt # created after installing libvirt
```

Exit from the container (run `exit` command) to apply changes made above.

You may want to load [my dotfiles](https://github.com/mars-low/dotfiles) inside the container:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/mars-low/myminidevenv.git
```

The basic maintenance of podman containers:

```sh
sudo podman container ls -a # list all containers
sudo podman container stop dev_codespace # stop container by name
sudo podman container start dev_codespace # start container by name
```

After starting the container you may see an issue during running `apt update` or `vncserver`.
It results in warning `sudo: unable to resolve host` (https://askubuntu.com/a/59517).
To fix it, add the following line to _/etc/hosts_ in the container, if it's not there yet:

```sh
127.0.1.1    debian-12
```

A container is run in _privileged_ mode with all capabilities and network shared with the host.
Privileged mode allows the container to perform actions as if it were the host.
All devices are bind mounted inside container so it's easy to work with hardware.
Most operations work the same way as outside of the container.

We mounted _/lib/modules_ directory from the host to the container, so it's possible to load kernel modules.
Remember the container uses the kernel modules of the host, so they are loaded in the host.

```sh
sudo modprobe vhci-hcd
sudo modprobe usbip-core
sudo modprobe usbip-host
sudo modprobe usbmon
sudo modprobe usbtest vendor=0x2fe3 product=0x0009
```

SSH from the inside of VM to the container:

```sh
ssh -p 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null codespace@localhost
```

Connect with ssh from the host to the container with _debian-12_ VM as a jump server and redirect a few ports:

```sh
sh -A -F $( vl ssh_config > .ssh_config | echo .ssh_config) codespace@localhost -p 2222 -J debian-12 -L 3000:127.0.0.1:3000 -L 3389:127.0.0.1:3389 -L 5902:127.0.0.1:5902 -L 8080:127.0.0.1:8080 -L 8085:127.0.0.1:8085 -L 5038:127.0.0.1:5037 -L 7173:127.0.0.1:7173 -L 8443:127.0.0.1:8443 -L 5013:127.0.0.1:5013 -L 9222:127.0.0.1:9222 -R 27183:127.0.0.1:27183 -R 27184:127.0.0.1:27184 -R 3240:127.0.0.1:3240 -R 3241:127.0.0.1:3241 -R 3242:127.0.0.1:3242 -R 3243:127.0.0.1:3243 -R 4656:127.0.0.1:4656 -R 4657:127.0.0.1:4657 -o EnableEscapeCommandline=yes
```

Given that host itself runs ssh server and you can connect to it with `ssh antcon`, you can further redirect ports.
SSH connection between libvirt host and VM guest listed above must be still active.

```sh
ssh antcon -L 3000:127.0.0.1:3000 -L 3389:127.0.0.1:3389 -L 5902:127.0.0.1:5902 -L 8080:127.0.0.1:8080 -L 8085:127.0.0.1:8085 -L 5000:127.0.0.1:5000 -L 5001:127.0.0.1:5001 -L 5038:127.0.0.1:5038 -L 8443:127.0.0.1:8443 -L 7173:127.0.0.1:7173 -L 5013:127.0.0.1:5013 -L 9222:127.0.0.1:9222 -R 27183:127.0.0.1:27183 -R 27184:127.0.0.1:27184 -R 3243:127.0.0.1:3243 -R 27185:127.0.0.1:27185 -R 4657:127.0.0.1:4657 -o EnableEscapeCommandline=yes
```

# Linux kernel tweaks

Tweak some kernel settings according to your preference:

```sh
sudo sysctl -w fs.inotify.max_user_instances=524288
sudo sysctl -w fs.inotify.max_user_watches=5242880
sudo sysctl -w kernel.perf_event_paranoid=-1
sudo sysctl -p
```

# Usage

```sh
code-server --bind-addr 0.0.0.0:8080 --disable-getting-started-override --disable-telemetry --user-data-dir /vm-storage/repos/personal/code-server/Data --extensions-dir /vm-storage/repos/personal/code-server/Extensions --auth none --app-name codespace
```

```sh
vncserver # set password
./utils/novnc_proxy --listen 127.0.0.1:5902  --vnc 127.0.0.1:5901
```

Connnect to VNC server from the host:

```sh
chromium --app="http://127.0.0.1:5902/vnc.html?host=127.0.0.1&port=5902" --enable-features=UseOzonePlatform --ozone-platform=wayland
```

or

```sh
firefox --kiosk http://127.0.0.1:5902/vnc.html?host=127.0.0.1&port=5902
```

For the best experience, in Firefox configure session restore.
Pick an option _Startup->Open previous windows and tabs_.

Kiosk mode may not be optimal for dual screen setup, as it tends to fullscreen to a single display.

As an alternative, set _full-screen-api.ignore-widgets_ to true in _about:config_
and resize window manually to span two screens (Firefox only).

For the best experience [Disable fullscr-toggler in Firefox](https://stackoverflow.com/questions/35836338/firefox-browser-settings-to-avoid-appearance-of-menu-bar-or-task-bar-in-full-scr/35836449#35836449).

Use [Hide Top Bar extension for GNOME Shell](https://extensions.gnome.org/extension/545/hide-top-bar/).
Download extension from a linked page and install from the command line:

```sh
gnome-extensions install --force hidetopbarmathieu.bidon.ca.v114.shell-extension.zip
```

Logout and login again:

```sh
$ gnome-extensions list
hidetopbar@mathieu.bidon.ca
```

```sh
gnome-extensions enable hidetopbar@mathieu.bidon.ca
```

Open GNOME Extensions and `Settings` for _Hide Top Bar_ and leave selected only `Show panel in overview` option.

# Commonly used commands

## virtualenv

Create Python virtual environment in _.venv_312_ directory:

```sh
virtualenv .venv_312 # create
source .venv_312/bin/activate # activate
which python # check if python points to your venv
```

## git

```sh
git fetch --all && git pull origin master
git submodule update --recursive
```

## swap memory

Increase swap memory on the host system to prevent Linux's OOM killer from killing VM:

```sh
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
```

## clangd

### tlib

```sh
cd tlib
mkdir build && cd build
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DTARGET_ARCH=arm64 -DTARGET_WORD_SIZE=64  ..
```

### Zephyr

```sh
cd zephyrproject/zephyr
west build -p auto -b nrf52840dk/nrf52840 samples/subsys/usb/webusb -- -DCMAKE_EXPORT_COMPILE_COMMANDS=1
```

### Linux

```sh
cd linux
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make -j6
python scripts/clang-tools/gen_compile_commands.py
```

For cross-compiled kernels, remove `-mabi=lp64` from _compile_commands.json_
becasue [clangd does not work with cross-compiled kernel](https://github.com/clangd/clangd/issues/1653).

## udev

Working with _udev_ inside the container is simple.
Monitor _udev_ events with:

```sh
udevadm monitor
```

Start _udev_ in daemon mode (replacement for _systemd_ service):

```sh
sudo /lib/systemd/systemd-udevd --daemon
```

Reload rules and observe multiple events in _udevadm monitor_:

```sh
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## Renode

```sh
renode --net --disable-gui --port 1024
telnet localhost 1024
```

## flatpak

Flatpak allows to install applications in arbitrary directory (e.g. on hard drive)
All applications data is also stored in user's specified directory.
It allows for an easy migration in the case of system's reinstall.

Initial setup for installing into an arbitrary directory.
Set _$FLATPAK_SYSTEM_DIR_ according to your liking:

```sh
sudo tee $FLATPAK_SYSTEM_DIR/repo/config <<EOF
[core]
repo_version=1
mode=bare-user-only
min-free-space-size=500MB
EOF
```

Add _flathub_ remote if you want to install "official" applications:

```sh
HOME=$FLATPAK_HOME flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

Update installed apps:

```sh
HOME=$FLATPAK_HOME flatpak update --user
```

## audio

`pipewire` is used for audio management.

Set environment variables for `pipewire` (https://walkergriggs.com/2022/12/03/pipewire_in_docker/). They must be set in every opened shell.

```sh
export DISABLE_RTKIT=y
export XDG_RUNTIME_DIR=$HOME
export PIPEWIRE_RUNTIME_DIR=$HOME
export PULSE_RUNTIME_DIR=$HOME
```

Start pipewire in container without user session (no graphical environment)

```sh
dbus-run-session -- pipewire
```

If you get an error:

```txt
dbus[1647430]: Unable to set up transient service directory: XDG_RUNTIME_DIR "/home/codespace" can be written by others (mode 042775)
```

Then change permissions for `$XDG_RUNTIME_DIR` and try again:

```sh
sudo chown -R codespace:codespace $XDG_RUNTIME_DIR
sudo chmod 755 $XDG_RUNTIME_DIR
```

In the second terminal run a session manager:

```sh
dbus-run-session -- wireplumber # alternatively (obsolete): dbus-run-session -- pipewire-media-session
```

In the third terminal:

```sh
pipewire-pulse
```

## SSH config

If your setup includes proxy jump or is arbitrarily more complex, you may want to configure it in ssh config file (it should be placed in _~/.ssh/config_).

Proxy jump configuration allows you to connect to
remote machine with a simple `ssh myremote` command:

```txt
Host mygate
  HostName 192.168.1.37
  Port 8022
  User codespace_gate
Host myremote
  HostName 10.10.28.121
  User codespace
  ProxyJump mygate
```

## qemu

```sh
qemu-system-aarch64 -bios coreboot/build/coreboot.rom \
-M virt,secure=on,virtualization=on,gic-version=3 \
-cpu cortex-a53 \
-S -s \
-smp 4 \
-monitor telnet::45454,server,nowait \
-serial mon:stdio \
-display none -m 8192 \
-qmp unix:/tmp/qmp-sock,server=on,wait=offq
```

## [devcontainers](https://github.com/devcontainers)

```sh
npm install -g @devcontainers/cli
devcontainer outdated --workspace-folder .
rm .devcontainer/devcontainer-lock.json
devcontainer upgrade --workspace-folder .
```

## bumble

```sh
bumble-hci-bridge android-netsim:name=bumble1 tcp-client:127.0.0.1:3456
bumble-hci-bridge android-netsim:name=bumble2 tcp-client:127.0.0.1:3457
```

## adb

[Connect to Chrome DevTools Protocol (CDP) of your Chrome on Android manually through Android Debug Bridge (adb)](https://developer.chrome.com/docs/devtools/remote-debugging#adb):

```sh
adb forward tcp:9222 localabstract:chrome_devtools_remote
```
