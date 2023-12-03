#!/bin/bash

# Check if debian helpers are on the system
if ! command -v "dch" >/dev/null 2>&1; then
	echo "'dch' from 'devscripts' is not installed!"
	echo "on debian install it with: sudo apt install -y devscripts"
	echo "on arch, install it from AUR: yay -S devscripts"
	exit 1
fi

new_pkgver=$(git rev-list --count HEAD)
new_pkgver=$((new_pkgver + 1)) # +1 because the script is executed before commit

cd ..

# Update Arch PKGBUILD version number
sed -i "s/^pkgver=.*/pkgver=${new_pkgver}/" arch/PKGBUILD

# Update DEBIAN version number
sed -i "s/Version: .*/Version: ${new_pkgver}/" DEBIAN/control


# Maintainer-information (set to the owner of the PPA)
export DEBFULLNAME="Linus Moser"
export DEBEMAIL="megakuulr@gmail.com"

# What you're seeing is not a dream, this is the standard practice for small debian packages to be maintained...
# I mean why not, it's just like bringing a Panther KF51 to a Nerf battle...

distributions=("focal" "bionic" "jammy" "lunar" "mantic" "buster" "bullseye")

for dist in "${distributions[@]}"; do
    dch -v "${new_pkgver}" -D "$dist" -m "Continuous stable release, automatically generated by update_version.sh script"
done

