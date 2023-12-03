# Megakuul Commander

A good filexplorer for Linux

## Install Software

#### Ubuntu

Build from official ppa repository:
```bash
sudo add-apt-repository ppa:megakuul/mkc
sudo apt update
sudo apt install mkc
```

Remove the package with:
```bash
sudo apt remove mkc
```

#### Debian

Build from *.deb* release:
```bash
wget https://github.com/megakuul/mkc/releases/download/latest/mkc.deb
sudo dpkg -i mkc.deb
```

Remove the package with:
```bash
sudo apt remove mkc
```

#### Arch

Build from *PKGBUILD*:
```bash
git clone https://github.com/megakuul/mkc.git 
curl -o PKGBUILD https://raw.githubusercontent.com/Megakuul/MKC/main/arch/PKGBUILD
makepkg -si
```

Or if the link is unavailable you can just download the full repository:
```bash
git clone https://github.com/megakuul/mkc.git
cd mkc/arch
makepkg -si
```

Remove the package with:
```bash
sudo pacman -R mkc-git
```

## Update model

The Megakuul Commander package uses a very simple continuous update model. The version of the software is determined by the commit-number on the *main* branch.

There is no "unreleased", "beta" or "preview" version, the newest version is always marked as "stable". If issues occur, they are fixed in the latest version -> Old versions are not maintained or changed in any way.

On *ubuntu*, you can just update the package like regular packages:
```bash
sudo apt update -y
sudo apt upgrade -y
```

On *debian*, you must re-download the package and reinstall it:
```bash
wget https://github.com/megakuul/mkc/releases/download/latest/mkc.deb
sudo dpkg -i mkc.deb
```

For *arch* distros, you must again fetch the install script and execute it:
```bash
git clone https://github.com/megakuul/mkc.git 
curl -o PKGBUILD https://raw.githubusercontent.com/Megakuul/MKC/main/arch/PKGBUILD
makepkg -si
```

## Build arch package

The arch package does not need to be built as it is not part of a public repository. In the *arch* directory you will find the *PKGBUILD* script that is used to install the software.


## Build debian package

#### Binary package

Building the binary package is handled with the *DEBIAN* folder structure, this folder can be used as *stable* fallback option, different to the *debian* dir, this package has a very simple structure and does manually compile the project with the local build tools.



To build the binary package (.deb) you can use the script located in the *scripts* dir:

```bash
cd scripts
bash debian_build_binary.sh
```

The script will tell you if you need to install a dev/make-dependency.

Versioning is handled through *git*, the current git commit is taken as version.

After successfull build there should be a file called *mkc.deb*.

You can install this file like that:

```bash
sudo dpkg -i mkc.deb
```


#### Source package

Building the source package is handled with the *debian* folder structure, it's used to build the project source package, this is usually required when uploading the package to a PPA or another Repository. Compared to the *DEBIAN* structure it's more complex and relies on compilation and dependency-handling based on debians packaging structure.

To build the source package (_source.changes & .dsc etc.) for e.g. uploading to a ppa you can use the script in the *scripts* dir:

```bash
cd scripts
bash debian_build_source.sh <gpg-email>
```

If you provide a mail address to the script, it signes the *.changes* and *.dsc* file with the local gpg key that matches the mail address. Omitting the mail will just not sign the files.


#### Test package

To locally test / install the package you can use:

```bash
cd scripts
bash debian_debug_local.sh
```

If there are unresolved dependencies dpkg (used inside the script) will complain, you can resolve it with:

```bash
sudo apt -f install
```
