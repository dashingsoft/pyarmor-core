set -e

ver=$1
if [[ -z "$ver" ]] ; then
    echo "No version specified"
    exit 1
fi

svruser="root@snsoffice.com"
svrpath=/var/www/pyarmor/downloads/$ver

echo "Create remote path: $svrpath"
ssh -i ~/.ssh/aliyun_id_rsa root@snsoffice.com "mkdir -p $svrpath"

for path in ./ ; do
    echo "Search *pytransform.*  in $path ..."
    echo "-----------------------------------------"
    for src in $(find $path -name *pytransform.*) ; do
        platform=$(basename $(dirname $src))
        # if [[ "$platform" == "x64" || "$platform" == "x86" ]] ; then
        #   platform=$(dirname $src)
        #   platform=${platform#./}
        # fi
        dest="$svruser:$svrpath/$platform"
        echo "Upload $src to $dest"
        ssh -i ~/.ssh/aliyun_id_rsa $svruser "mkdir -p $svrpath/$platform"
        scp -i ~/.ssh/aliyun_id_rsa $src $dest
    done
    echo "-----------------------------------------"
    echo ""
done

# Update hash of dynamic library
# python make-hash.py

echo "Upload index.json to $svruser:$svrpath"
scp -i ~/.ssh/aliyun_id_rsa index.json $svruser:$svrpath/
