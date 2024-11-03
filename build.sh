#! /usr/bin/env bash

# Example build script, required system dependecies installed: gmp gmp-ecm

# Create an empty dir, copy script inside and execute it

cd "$(dirname "$0")"

git clone https://github.com/gilcu3/yafu.git
git clone https://github.com/bbuhrow/ytools.git
git clone https://github.com/bbuhrow/ysieve.git
svn co svn://svn.code.sf.net/p/msieve/code/trunk msieve

cd ytools
make CC=gcc CFLAGS="$CFLAGS -Wno-error=implicit-function-declaration"
cp libytools.a ../ysieve/

cd ../ysieve
make CC=gcc CFLAGS="$CFLAGS -g -O2 -fomit-frame-pointer -Wall  -I.  -I../ytools -Wno-error=incompatible-pointer-types"
cp libytools.a ../yafu/
cp libysieve.a ../yafu/

cd ../msieve
make all NO_ZLIB=1

cd ../yafu
make yafu NFS=1

