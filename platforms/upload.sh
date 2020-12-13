set -e
prefix="root@snsoffice.com:/var/www/pyarmor/downloads"

ver=$1
if [[ -z "$ver" ]] ; then
    echo "No version specified"
    exit 1
fi

echo "Create remote path: /var/www/pyarmor/downloads/$ver"
ssh -i ~/.ssh/aliyun_id_rsa root@snsoffice.com "rm -rf /var/www/pyarmor/downloads/$ver; cd /var/www/pyarmor/downloads; mkdir $ver"

for path in ./ ; do
    echo "Search path $path ..."
    echo "-----------------------------------------"
    for src in $(find $path -name *pytransform.*) ; do
        platform=$(basename $(dirname $src))
        # if [[ "$platform" == "x64" || "$platform" == "x86" ]] ; then
        #   platform=$(dirname $src)
        #   platform=${platform#./}
        # fi
        dest="$prefix/$ver/$platform"
        echo "Upload $src to $dest"
        ssh -i ~/.ssh/aliyun_id_rsa root@snsoffice.com "mkdir -p /var/www/pyarmor/downloads/$ver/$platform"
        scp -i ~/.ssh/aliyun_id_rsa $src $dest
    done
    echo "-----------------------------------------"
    echo ""
done

# echo "Upload README.html to $prefix/platforms.html"
# scp -i ~/.ssh/aliyun_id_rsa README.html $prefix/platforms.html

# Update hash of dynamic library
# python make-hash.py

echo "Upload index.json to $prefix/$ver"
scp -i ~/.ssh/aliyun_id_rsa index.json $prefix/$ver/
