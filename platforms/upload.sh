prefix="root@snsoffice.com:/var/www/pyarmor/downloads"

for path in ./ ; do
    echo "Search path $path ..."
    echo "-----------------------------------------"
    for src in $(find $path -name *pytransform.*) ; do
        platform=$(basename $(dirname $src))
        # if [[ "$platform" == "x64" || "$platform" == "x86" ]] ; then
        #   platform=$(dirname $src)
        #   platform=${platform#./}
        # fi
        dest="$prefix/latest/$platform"
        echo "Upload $src to $dest"
        scp -i ~/.ssh/aliyun_id_rsa $src $dest
    done
    echo "-----------------------------------------"
    echo ""
done

# echo "Upload README.html to $prefix/platforms.html"
# scp -i ~/.ssh/aliyun_id_rsa README.html $prefix/platforms.html

# Update hash of dynamic library
# python make-hash.py

echo "Upload index.json to $prefix/latest"
scp -i ~/.ssh/aliyun_id_rsa index.json $prefix/latest/

ver=$1
if [[ -n "$ver" ]] ; then
    echo "Copy latest to remote path: /var/www/pyarmor/downloads/$ver"
    ssh -i ~/.ssh/aliyun_id_rsa root@snsoffice.com "rm -rf /var/www/pyarmor/downloads/$ver; cd /var/www/pyarmor/downloads; cp -a latest/ $ver"
fi
