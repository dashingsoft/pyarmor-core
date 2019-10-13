prefix="root@snsoffice.com:/var/www/pyarmor/downloads/latest"

for path in ./ ; do
    echo "Search path $path ..."
    echo "-----------------------------------------"
    for src in $(find $path -name _pytransform.*) ; do
        platform=$(basename $(dirname $src))
        if [[ "$platform" == "x64" || "$platform" == "x86" ]] ; then
          platform=$(dirname $src)
          platform=${platform#./}
        fi
        dest="$prefix/$platform"
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

echo "Upload index.json to $prefix/"
scp -i ~/.ssh/aliyun_id_rsa index.json $prefix/
