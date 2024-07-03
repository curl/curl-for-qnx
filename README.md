# curl-for-qnx
Scripts and configs for building curl for QNX

## Howto

1. download a release archive
2. `./mkrelease.sh [tarball]`

Wait a while

3. Sign the release per the instructions shown in the terminal
4. Upload the tarballs to the release site

## Build fixes

When a fix is done to the tarballs/releases that runs on the same curl release
tarball as before, bump the build number by providing the new build number to
the `mkrelease.sh` script. A second build is done like:

    ./mkrelease.sh [tarball] 2
