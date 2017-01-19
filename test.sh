#!/usr/bin/env bash

PY="python3"
LOCK_FILE="/opt/gamevox-pkgbuild-test/error.lock"
GIT_REPO="https://aur.archlinux.org/gamevox.git"
GIT_URL="https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gamevox"
GIT_FILE="PKGBUILD"
GIT_FOLDER="./gamevox"

doMD5Test(){
	#wget -O $GIT_FILE $GIT_URL
	git clone $GIT_REPO
	MD5LINE="$(grep gamevox/PKGBUILD -e 'md5sums=(')"
	PKGMD5="${MD5LINE:10:-1}"
	SRCLINE="$(grep gamevox/PKGBUILD -e 'source=(')"
	NEWMD5="$(curl ${SRCLINE:9:-1}|md5sum|cut -d ' ' -f 1)"
	printf "Old MD5: %s\nNew MD5: %s\n" "$PKGMD5" "$NEWMD5"
	case $PKGMD5 in
		$NEWMD5)
			echo "MD5 checksums are still the same!";;
		*)
			echo "MD5 checksums are different!"
			emailMaintainer;;
	esac
}

emailMaintainer(){
	echo "Emailing maintainer"
	#$py ./email.py "$GIT_FILE"
}

cleanup(){
	if [ -d $GIT_FOLDER ];then
		rm -rf $GIT_FOLDER
	fi
}

cd "/opt/gamevox-pkgbuild-test/"
if [ ! -f "$LOCK_FILE" ]; then
	doMD5Test
	#cleanup
fi
