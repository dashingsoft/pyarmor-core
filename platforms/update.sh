#! /bin/bash
#
# Create TARGET tag in remote server, but only upload the changed
# files, for other files create links from SRC tag
#
# Usage:
#     bash update.sh SRC TARGET
#
# For example, update tag r31.5a by r31.5
#
#    bash update.sh r31.5 r31.5a
#
set -e

rpath="/var/www/pyarmor/downloads"
prefix="root@snsoffice.com:$rpath"

src=$1
dst=$2

if [[ -z "$src" || -z "$(git tag -l $src)" ]] ; then
    echo "No source tag"
    exit 1
fi

if [[ -z "$dst" ]] ; then
    echo "Target tag is empty"
    exit 1
fi

echo "Create remote path: $rpath/$dst"
ssh -i ~/.ssh/aliyun_id_rsa root@snsoffice.com "rm -rf $rpath/$dst; cd $rpath; mkdir $dst;"

files=$(git diff --name-only $src -- *.pyd *.dll *.so *.dylib)
for x in $files ; do
    x=${x#platforms/}
    echo "Upload $x"
    name=$(dirname ${x})
    ssh -i ~/.ssh/aliyun_id_rsa root@snsoffice.com "mkdir $rpath/$dst/$name"
    scp -i ~/.ssh/aliyun_id_rsa $x $prefix/$dst/$x
done

echo "Make link for unchanged libraries"
ssh -i ~/.ssh/aliyun_id_rsa root@snsoffice.com "cd $rpath; bash make-tag-link.sh $src $dst"

echo "Upload index.json to $prefix/$dst"
echo scp -i ~/.ssh/aliyun_id_rsa index.json $prefix/$dst
