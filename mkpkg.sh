#!/bin/sh

buildver=$1

if [ -z "$buildver" ]; then
  echo "Provide build version string"
  exit
fi

build="_build"
install="$PWD/_install"

# start a clean slate

rm -rf $build

###
### 8.0 section
###

## 8.0 aarch64

aprefix="$install/aarch64-8.0.0"
atargetlibdir="$build/target/qnx/aarch64le/usr/lib/wolfssl"
atargetbindir="$build/target/qnx/aarch64le/usr/bin/wolfssl"
atargetincdir="$build/target/qnx/aarch64le/usr/include/wolfssl/curl"
astrip="aarch64-unknown-nto-qnx8.0.0-strip"

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

## 8.0 x86_64

xprefix="$install/x86_64-8.0.0"
xtargetlibdir="$build/target/qnx/x86_64/usr/lib/wolfssl"
xtargetbindir="$build/target/qnx/x86_64/usr/bin/wolfssl"
xtargetincdir="$build/target/qnx/x86_64/usr/include/wolfssl/curl"
xstrip="x86_64-pc-nto-qnx8.0.0-strip"

mkdir -p $xtargetlibdir
cp -p $xprefix/lib/libcurl.a $xprefix/lib/libcurl.so* $xtargetlibdir
cp -p $xprefix/lib/libcurl.so.12 $xtargetlibdir/libcurl.so.12.sym
$xstrip $xtargetlibdir/libcurl.so.12 $xtargetlibdir/libcurl.so

mkdir -p $xtargetbindir
cp -p $xprefix/bin/curl $xtargetbindir
cp -p $xprefix/bin/curl $xtargetbindir/curl.sym
$xstrip $xtargetbindir/curl

mkdir -p $xtargetincdir
cp -p $xprefix/include/curl/*.h $xtargetincdir

## 8.0 documentation

cp README-QNX.md "$build/target/qnx/"

###
### 7.0 section
###

install="$HOME/qnx7-install"

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

## build the 8.0 package

cd $build
tar czf curl-$buildver-qnxsdp8.0.tar.gz target/qnx

## build the 7.0 package

tar czf curl-$buildver-qnxsdp7.0.tar.gz target/qnx7
