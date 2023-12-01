#!/bin/bash

commit_number=$(git rev-list --count HEAD)
current_version=$(dpkg-parsechangelog -S Version)
new_version="$commit_number-1"

cd mkc/

if [ "$current_version" != "$new_version" ]; then
    dch -v "$new_version" -m "Release automatically generated by build_source.sh script"
else
    echo "Version $new_version already exists in changelog, skipping dch."
fi

cd ..

tar -czvf "mkc_$commit_number.orig.tar.gz" ../../*

set -e

cd mkc/
dpkg-buildpackage -S
cd ..

gpg --verify "mkc_$new_version.dsc"
gpg --verify "mkc_$new_version.changes"