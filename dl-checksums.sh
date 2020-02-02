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
        wget -q -O $lchecksums $url
    fi

    printf "  # %s\n" $url
    printf "  %s:\n" $ver

    dl $ver $lchecksums darwin amd64
    dl $ver $lchecksums linux amd64
    dl $ver $lchecksums windows amd64
}

dl_ver ${1:-v3.5.4}
