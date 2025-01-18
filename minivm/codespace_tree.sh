#!/usr/bin/env bash

mkdir repos && pushd repos || exit
mkdir android && pushd android || exit

# https://developer.android.com/studio#command-tools
# android-sdk
# TODO

# https://source.android.com/docs/setup/start/requirements
# aosp
# TODO

# https://source.android.com/docs/devices/cuttlefish/get-started
# cf
# TODO

# https://source.android.com/docs/devices/cuttlefish/get-started
# android-cuttlefish
git clone https://github.com/google/android-cuttlefish
git clone https://gitlab.com/newbit/rootAVD.git
git clone https://gitlab.com/newbit/usbhostpermissions.git

mkdir apps && pushd apps || exit

git clone https://codeberg.org/Freeyourgadget/Gadgetbridge.git
git clone https://github.com/kai-morich/SimpleUsbTerminal.git
git clone https://github.com/kshoji/USB-MIDI-Driver.git

popd || exit # apps -> android
popd || exit # android -> repos

# https://www.chromium.org/chromium-os/developer-library/getting-started/development-environment/
# depot_tools
# chromium
# TODO

git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
pushd linux || exit
git remote add github https://github.com/torvalds/linux.git
popd || exit # linux -> repos

# https://llvm.org/docs/GettingStarted.html#getting-the-source-code-and-building-llvm
git clone https://github.com/llvm/llvm-project.git
git clone https://github.com/renode/renode
git clone https://github.com/microsoft/vscode.git

mkdir vscode-extensions && pushd vscode-extensions || exit

git clone https://github.com/icsharpcode/ilspy-vscode.git
git clone https://github.com/dotnet/interactive.git
git clone https://github.com/AykutSarac/jsoncrack-vscode.git
git clone https://github.com/mcu-debug/peripheral-viewer.git
git clone https://github.com/platformio/platformio-vscode-ide.git
git clone https://github.com/nia40m/vscode-display-nums
git clone https://github.com/microsoft/vscode-extension-samples.git
git clone https://github.com/microsoft/vscode-gradle.git
git clone https://github.com/eirikpre/VSCode-SystemVerilog.git
git clone https://github.com/wasmerio/vscode-wasm.git

popd || exit # vscode-extensions -> repos

mkdir others && pushd others || exit

git clone https://github.com/google/perfetto.git
pushd perfetto || exit
git remote add android https://android.googlesource.com/platform/external/perfetto/
popd || exit # perfetto -> others

git clone https://github.com/google/bumble.git
git clone https://github.com/universal-ctags/ctags.git
git clone https://github.com/greatscottgadgets/facedancer.git
git clone https://github.com/libusb/hidapi
git clone https://github.com/todbot/hidapitester
git clone https://github.com/ondrejbudai/hidviz.git
git clone https://github.com/stefanberger/libtpms.git
git clone https://github.com/novnc/noVNC.git
git clone https://github.com/antmicro/pyrenode3.git
git clone https://github.com/MHDante/pythonnet-stub-generator.git
git clone https://github.com/MikePopoloski/slang.git
git clone https://github.com/stefanberger/swtpm.git
git clone https://github.com/JohnDMcMaster/usbrply.git
git clone https://github.com/verilator/verilator.git

popd || exit # others -> repos

mkdir embedded && pushd embedded || exit

git clone https://github.com/adafruit/Adafruit_nRF52_Bootloader
git clone https://sourceware.org/git/binutils-gdb.git
git clone https://github.com/buildroot/buildroot.git
git clone https://git.busybox.net/busybox/
git clone https://github.com/adafruit/circuitpython.git
git clone https://github.com/cmtp-responder/cmtp-responder.git
git clone https://github.com/contiki-ng/contiki-ng.git
git clone https://github.com/mbedmicro/DAPLink
git clone https://github.com/embassy-rs/embassy.git
git clone https://github.com/linux-usb-gadgets/gt.git
git clone https://github.com/aagallag/hid_gadget_test.git
git clone https://github.com/IntergatedCircuits/HidSharp.git
git clone https://github.com/microsoft/hidtools.git
git clone https://github.com/microsoft/hidtools.wiki.git
git clone https://git.code.sf.net/p/libmtp/code
git clone https://github.com/linux-usb-gadgets/libusbgx.git
git clone https://github.com/littlefs-project/littlefs-fuse.git
git clone https://github.com/jrast/littlefs-python.git
git clone https://github.com/micropython/micropython.git
git clone https://github.com/apache/mynewt-newt.git
git clone https://github.com/apache/mynewt-nimble.git
git clone https://github.com/hathach/mynewt-tinyusb-example.git
git clone https://github.com/google/OpenSK.git
git clone https://gitlab.com/qemu-project/qemu.git
git clone https://github.com/renesas/ra-fsp-examples.git
git clone https://github.com/xairy/raw-gadget.git
git clone https://github.com/RIOT-OS/RIOT
git clone https://github.com/hathach/tinyusb
git clone https://github.com/viveris/uMTP-Responder.git
git clone https://github.com/AristoChen/usb-proxy.git
git clone https://gitlab.freedesktop.org/camera/uvc-gadget.git
git clone https://github.com/espressif/esp-idf.git
git clone https://github.com/ARM-software/arm-trusted-firmware

# https://nuttx.apache.org/docs/latest/quickstart/install.html
mkdir nuttxspace
pushd nuttxspace || exit
git clone https://github.com/apache/nuttx.git nuttx
git clone https://github.com/apache/nuttx-apps apps
popd || exit # nuttxspace -> embedded

# https://openthread.io/codelabs/openthread-hardware#2
mkdir OpenThread
pushd OpenThread || exit
git clone --recursive https://github.com/openthread/openthread.git
git clone --recursive https://github.com/openthread/ot-nrf528xx.git
popd || exit # OpenThread -> embedded

# https://docs.zephyrproject.org/latest/develop/getting_started/index.html
# zephyrproject
# zephyr-sdk-0.17.0

popd || exit # embedded -> repos
