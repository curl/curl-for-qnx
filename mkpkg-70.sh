#!/bin/sh

buildver=$1

if [ -z "$buildver" ]; then
  echo "Provide build version string: x.y.z-n"
  exit
fi

tarball="`pwd`/_tarball"
build="_build"
install="$PWD/_install"

mkdir -p $tarball

###
### 7.0 section
###

## 7.0 aarch64

aprefix="$install/aarch64-7.0.0"
atargetlibdir="$build/target/qnx7/aarch64le/usr/lib/wolfssl"
atargetbindir="$build/target/qnx7/aarch64le/usr/bin/wolfssl"
atargetincdir="$build/target/qnx7/aarch64le/usr/include/wolfssl/curl"
astrip="aarch64-unknown-nto-qnx7.0.0-strip"

mkdir -p $atargetlibdir
cp -p $aprefix/lib/libcurl.a $aprefix/lib/libcurl.so* $atargetlibdir
cp -p $aprefix/lib/libcurl.so.12 $atargetlibdir/libcurl.so.12.sym
$astrip $atargetlibdir/libcurl.so.12 $atargetlibdir/libcurl.so

mkdir -p $atargetbindir
cp -p $aprefix/bin/curl $atargetbindir
cp -p $aprefix/bin/curl $atargetbindir/curl.sym
$astrip $atargetbindir/curl

mkdir -p $atargetincdir
cp -p $aprefix/include/curl/*.h $atargetincdir

## 7.0 armle-v7

aprefix="$install/armle-v7-7.0.0"
atargetlibdir="$build/target/qnx7/armle-v7le/usr/lib/wolfssl"
atargetbindir="$build/target/qnx7/armle-v7le/usr/bin/wolfssl"
atargetincdir="$build/target/qnx7/armle-v7le/usr/include/wolfssl/curl"
astrip="arm-unknown-nto-qnx7.0.0eabi-strip"

mkdir -p $atargetlibdir
cp -p $aprefix/lib/libcurl.a $aprefix/lib/libcurl.so* $atargetlibdir
cp -p $aprefix/lib/libcurl.so.12 $atargetlibdir/libcurl.so.12.sym
$astrip $atargetlibdir/libcurl.so.12 $atargetlibdir/libcurl.so

mkdir -p $atargetbindir
cp -p $aprefix/bin/curl $atargetbindir
cp -p $aprefix/bin/curl $atargetbindir/curl.sym
$astrip $atargetbindir/curl

mkdir -p $atargetincdir
cp -p $aprefix/include/curl/*.h $atargetincdir

## 7.0 x86_64

aprefix="$install/x86_64-7.0.0"
atargetlibdir="$build/target/qnx7/x86_64/usr/lib/wolfssl"
atargetbindir="$build/target/qnx7/x86_64/usr/bin/wolfssl"
atargetincdir="$build/target/qnx7/x86_64/usr/include/wolfssl/curl"
astrip="x86_64-pc-nto-qnx7.0.0-strip"

mkdir -p $atargetlibdir
cp -p $aprefix/lib/libcurl.a $aprefix/lib/libcurl.so* $atargetlibdir
cp -p $aprefix/lib/libcurl.so.12 $atargetlibdir/libcurl.so.12.sym
$astrip $atargetlibdir/libcurl.so.12 $atargetlibdir/libcurl.so

mkdir -p $atargetbindir
cp -p $aprefix/bin/curl $atargetbindir
cp -p $aprefix/bin/curl $atargetbindir/curl.sym
$astrip $atargetbindir/curl

mkdir -p $atargetincdir
cp -p $aprefix/include/curl/*.h $atargetincdir

## 7.0 documentation

cp README-QNX.md "$build/target/qnx7/"

## build the 7.0 package

cd $build
tar czf curl-$buildver-qnxsdp7.0.tar.gz target/qnx7
mv *tar.gz $tarball
