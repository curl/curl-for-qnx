#!/bin/bash
#***************************************************************************
#                                  _   _ ____  _
#  Project                     ___| | | |  _ \| |
#                             / __| | | | |_) | |
#                            | (__| |_| |  _ <| |___
#                             \___|\___/|_| \_\_____|
#
# Copyright (C) Daniel Stenberg, <daniel@haxx.se>, et al.
#
# This software is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at https://curl.se/docs/copyright.html.
#
# You may opt to use, copy, modify, merge, publish, distribute and/or sell
# copies of the Software, and permit persons to whom the Software is
# furnished to do so, under the terms of the COPYING file.
#
# This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
# KIND, either express or implied.
#
# SPDX-License-Identifier: curl
#
###########################################################################

set -eu

tarball="${1:-}"
build="${2:-1}"

if [ -z "$tarball" ]; then
    echo "Provide a curl release tarball name as argument"
    exit
fi

i="0"
for dl in curl-*; do
    i=$(expr $i + 1)
done

if test "$i" -gt 1; then
    echo "pre-existing curl-* entries found, disambiguate please"
    exit
fi

. "./setup"

if [ -z "$QNX700" ]; then
    echo "Set QNX700 in the setup file"
    exit
fi

if [ -z "$QNX710" ]; then
    echo "Set QNX710 in the setup file"
    exit
fi

if [ -z "$QNX800" ]; then
    echo "Set QNX800 in the setup file"
    exit
fi


# remove previous curl release leftovers
rm -rf build-* _install _tarball

# extract the release contents
tar xf "$tarball"

curlver=$(grep '#define LIBCURL_VERSION ' curl-*/include/curl/curlver.h | sed 's/[^0-9.]//g')
buildver="$curlver-$build"

echo "Create QNX curl release $buildver"

# install everything here
mkdir _install

# make dedicated build dirs for every build
mkdir build-70-aarch64
mkdir build-70-armle-v7
mkdir build-70-x86_64

mkdir build-71-aarch64
mkdir build-71-armle-v7
mkdir build-71-x86_64

mkdir build-80-aarch64
mkdir build-80-x86_64

#
# SDK 7.0 builds
#

. "$QNX700/qnxsdp-env.sh" 2>&1 > /dev/null

## 7.0 for aarch64
pushd build-70-aarch64 >/dev/null
echo "7.0 aarch64"
echo " - configure"
sh ../conf/7.0-aarch64 >configure.log 2>&1
echo " - build"
make -sj >make.log 2>&1
echo " - install"
make install >make-install.log 2>&1
popd > /dev/null

## 7.0 for arlmle-v7
pushd build-70-armle-v7 > /dev/null
echo "7.0 armle-v7"
echo " - configure"
sh ../conf/7.0-armle-v7 >configure.log 2>&1
echo " - build"
make -sj >make.log 2>&1
echo " - install"
make install >make-install.log  2>&1
popd> /dev/null

## 7.0 for x86_64
pushd build-70-x86_64 > /dev/null
echo "7.0 x86_64"
echo " - configure"
sh ../conf/7.0-x86_64 >configure.log 2>&1
echo " - build"
make -sj >make.log 2>&1
echo " - install"
make install >make-install.log  2>&1
popd> /dev/null

#
# SDK 7.1 builds
#

. "$QNX710/qnxsdp-env.sh" 2>&1 > /dev/null

## 7.1 for aarch64
pushd build-71-aarch64 >/dev/null
echo "7.1 aarch64"
echo " - configure"
sh ../conf/7.1-aarch64 >configure.log 2>&1
echo " - build"
make -sj >make.log 2>&1
echo " - install"
make install >make-install.log 2>&1
popd > /dev/null

## 7.1 for arlmle-v7
pushd build-71-armle-v7 > /dev/null
echo "7.1 armle-v7"
echo " - configure"
sh ../conf/7.1-armle-v7 >configure.log 2>&1
echo " - build"
make -sj >make.log 2>&1
echo " - install"
make install >make-install.log  2>&1
popd> /dev/null

## 7.1 for x86_64
pushd build-71-x86_64 > /dev/null
echo "7.1 x86_64"
echo " - configure"
sh ../conf/7.1-x86_64 >configure.log 2>&1
echo " - build"
make -sj >make.log 2>&1
echo " - install"
make install >make-install.log  2>&1
popd> /dev/null

#
# SDK 8.0 builds
#

. $QNX800/qnxsdp-env.sh 2>&1 > /dev/null

## 8.0 for aarch64
pushd build-80-aarch64 > /dev/null
echo "8.0 aarch64"
echo " - configure"
sh ../conf/8.0-aarch64 >configure.log 2>&1
echo " - build"
make -sj >make.log 2>&1
echo " - install"
make install >make-install.log  2>&1
popd > /dev/null

## 8.0 for x86_64
pushd build-80-x86_64 > /dev/null
echo "8.0 x86_64"
echo " - configure"
sh ../conf/8.0-x86_64 >configure.log 2>&1
echo " - build"
make -sj >make.log 2>&1
echo " - install"
make install >make-install.log  2>&1
popd > /dev/null

# generate the tarballs
sh mkpkg-70.sh $buildver
sh mkpkg-71.sh $buildver
sh mkpkg-8.sh $buildver

ls -l _tarball/curl-*

sh sign.sh
