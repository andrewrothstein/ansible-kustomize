#!/usr/bin/env sh
set -e
DIR=~/Downloads
APP=kustomize
MIRROR=https://github.com/kubernetes-sigs/${APP}/releases/download

dl() {
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local archive_type=${5:-tar.gz}
    local platform="${os}_${arch}"
    local file="${APP}_${ver}_${platform}.${archive_type}"
    local url="$MIRROR/${APP}%2F$ver/$file"
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(grep $file $lchecksums | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    local url="$MIRROR/${APP}%2F$ver/checksums.txt"
    local lchecksums="$DIR/${APP}_${ver}_checksums.txt"
    if [ ! -e $lchecksums ];
    then
        curl -sSLf -o $lchecksums $url
    fi

    printf "  # %s\n" $url
    printf "  %s:\n" $ver

    dl $ver $lchecksums darwin amd64
    dl $ver $lchecksums darwin arm64
    dl $ver $lchecksums linux amd64
    dl $ver $lchecksums linux arm64
    dl $ver $lchecksums linux ppc64le
    dl $ver $lchecksums linux s390x
}

# available version: curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases | fgrep tarball/kustomize
dl_ver ${1:-v5.5.0}
