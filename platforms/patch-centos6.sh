dest=${1:-centos6.x86_64}
filename=pytransform.so

if [[ "$dest" == "centos6.x86_64" ]] ; then
    src=linux_x86_64
    filename=_pytransform.so
    echo "Copy $src to $dest"
    cp $src/$filename $dest
fi
echo "Patching $dest/$filename"

READELF=readelf
test -x $READELF || READELF=/usr/local/opt/binutils/bin/readelf
AWK=gawk
test -x $AWK || AWK=awk

offset=$($READELF -V $dest/$filename | grep "Offset" | $AWK 'FNR == 3 { print $4; }')
if [[ -z "$offset" ]] ; then
    echo "No found offset of section '.gnu.version_r'"
    exit 1
fi
echo "Offset of section '.gnu.version_r': $offset"

let -i addr1=$(( $offset + 0x10 ))
let -i addr2=$(( $offset + 0x40 ))
echo "Copy 4 bytes from $(printf '%x' $addr1) to $(printf '%x' $addr2)"
xxd -s $addr1 -l 4 $dest/$filename | sed "s/$(printf '%x' $addr1)/$(printf '%x' $addr2)/" | xxd -r - $dest/$filename

let -i addr1=$(( $offset + 0x18 ))
let -i addr2=$(( $offset + 0x48 ))
echo "Copy 4 bytes from $(printf '%x' $addr1) to $(printf '%x' $addr2)"
xxd -s $addr1 -l 4 $dest/$filename | sed "s/$(printf '%x' $addr1)/$(printf '%x' $addr2)/" | xxd -r - $dest/$filename
