IDFILE="/Users/jondy/.ssh/server_id_rsa"
test -r $IDFILE || IDFILE="~/.ssh/jondy_ubuntu_svr_id_rsa"
echo "Idfile is $IDFILE"

RPATH="jondy@192.168.121.103:/home/jondy/workspace"
echo "Download remote files from $RPATH"

set -x
scp -i $IDFILE $RPATH/pyarmor-core/platforms/win_amd64/_pytransform.dll ./win_amd64
scp -i $IDFILE $RPATH/pyarmor-core/platforms/linux_x86_64/_pytransform.so ./linux_x86_64
scp -i $IDFILE $RPATH/pyarmor-core/platforms/linux_i386/_pytransform.so ./linux_i386
scp -i $IDFILE $RPATH/pytransform/cross-platform/raspberrypi/.libs/_pytransform.so ./raspberrypi
scp -i $IDFILE $RPATH/pytransform/cross-platform/bananapi/.libs/_pytransform.so ./bananapi
scp -i $IDFILE $RPATH/pytransform/cross-platform/orangepi/.libs/_pytransform.so ./orangepi
scp -i $IDFILE $RPATH/pytransform/cross-platform/armv5/.libs/_pytransform.so ./armv5
scp -i $IDFILE $RPATH/pytransform/cross-platform/armv7/.libs/_pytransform.so ./armv7
scp -i $IDFILE $RPATH/pytransform/cross-platform/armv8.32-bit/.libs/_pytransform.so ./armv8.32-bit
scp -i $IDFILE $RPATH/pytransform/cross-platform/armv8.64-bit/.libs/_pytransform.so ./armv8.64-bit
scp -i $IDFILE $RPATH/pytransform/cross-platform/ppc64le/.libs/_pytransform.so ./ppc64le
scp -i $IDFILE $RPATH/pytransform/cross-platform/freebsd/.libs/_pytransform.so ./freebsd
scp -i $IDFILE $RPATH/pytransform/cross-platform/alpine/.libs/_pytransform.so ./alpine
scp -i $IDFILE $RPATH/pytransform/cross-platform/alpine.arm/.libs/_pytransform.so ./alpine.arm
scp -i $IDFILE $RPATH/pytransform/cross-platform/android.aarch64/.libs/_pytransform.so ./android.aarch64
scp -i $IDFILE $RPATH/pytransform/cross-platform/poky-i586/.libs/_pytransform.so ./poky-i586
scp -i $IDFILE $RPATH/pytransform/cross-platform/ts-4600/_pytransform.so ./ts-4600
scp -i $IDFILE $RPATH/pyarmor-core/platforms/vs2015.x64/_pytransform.dll ./vs2015.x64
scp -i $IDFILE $RPATH/pyarmor-core/platforms/vs2015.x86/_pytransform.dll ./vs2015.x86
scp -i $IDFILE $RPATH/pyarmor-core/platforms/linux.x86.0/_pytransform.so ./linux.x86.0
scp -i $IDFILE $RPATH/pyarmor-core/platforms/linux.x86_64.0/_pytransform.so ./linux.x86_64.0
scp -i $IDFILE $RPATH/pyarmor-core/platforms/windows.x86_64.0/_pytransform.dll ./windows.x86_64.0
scp -i $IDFILE $RPATH/pyarmor-core/platforms/linux.armv7.0/_pytransform.so ./linux.armv7.0
scp -i $IDFILE $RPATH/pyarmor-core/platforms/linux.aarch32.0/_pytransform.so ./linux.aarch32.0
scp -i $IDFILE $RPATH/pyarmor-core/platforms/linux.aarch64.0/_pytransform.so ./linux.aarch64.0

if [[ $(uname) == 'Darwin' ]] ; then
    scp -i $IDFILE $RPATH/pyarmor-core/platforms/win32/_pytransform.dll ./win32
    scp -i $IDFILE $RPATH/pyarmor-core/platforms/windows.x86.0/_pytransform.dll ./windows.x86.0
else
    scp -i $IDFILE $RPATH/pyarmor-core/platforms/darwin.x86_64.0/_pytransform.dylib ./darwin.x86_64.0
    scp -i $IDFILE $RPATH/pyarmor-core/platforms/ios.arm64/_pytransform.dylib ./ios.arm64
fi
