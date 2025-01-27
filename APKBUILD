# Contributor: James Kirby <james.kirby@atlascity.io>
# Maintainer: James Kirby <james.kirby@atlascity.io>
pkgname=syslinux
pkgver=6.420
pkgrel=420
_ver="6.04-pre1"
pkgdesc="Boot loader for the CryptOS"
url="http://syslinux.org"
arch="x86 x86_64"
license="GPL"
makedepends="linux-headers nasm perl util-linux-dev gnu-efi-dev"
depends="mtools blkid mkinitfs"
triggers="syslinux.trigger=/boot"
install="syslinux.post-upgrade"
options="textrels"
ldpath="/usr/share/syslinux"

source="https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/Testing/6.04/syslinux-6.04-pre1.tar.xz
	update-extlinux.conf
	update-extlinux
	"
subpackages="$pkgname-doc $pkgname-dev"

_loaderarch=
case "$CARCH" in
x86)	_loaderarch=efi32;;
x86_64)	_loaderarch=efi64;;
esac

builddir="$srcdir"/$pkgname-$_ver
prepare() {
	cd "$builddir"
	for i in $source; do
		i=${i%%::*}
		case "$i" in
		*.patch) msg $i; patch -p1 -i "$srcdir"/$i || return 1;;
		esac
	done
}

build() {
	cd "$builddir"
	unset LDFLAGS
	make $_loaderarch installer || return 1
}

package() {
	cd "$builddir"
	make -j1 INSTALLROOT="$pkgdir" MANDIR=/usr/share/man \
		bios $_loaderarch install || return 1

	mkdir -p "$pkgdir"/etc/update-extlinux.d
	cp "$srcdir"/update-extlinux.conf "$pkgdir"/etc/
	sed "/^version=/s/=.*/=$pkgver-r$pkgrel/" "$srcdir"/update-extlinux \
		> "$pkgdir"/sbin/update-extlinux
	chmod 755 "$pkgdir"/sbin/update-extlinux
}

sha512sums="7927dd39be8e2dcf4138a6fea33def67d19d938379d694f15b48fdd2f5924c028b7a9e7bd71d0c7c6630c203e9e2a54296628e530632ad5e6f55b1ebefe8fc98  syslinux-6.04-pre1.tar.xz
c3ff809f9cd60aa8a837d9508e6fcd08204b03cd8a9df86ab42fc6a8fe68784416b359b46378fb0a8f4163bbcbe444957e0e5751c30ff4631d4677eaa94874f4  update-extlinux.conf
6b90164c5669744d1c3ba379d3d919bd16dfccb87e04ed5dcb6c324617fa0186840b359f5bb2d8515da3b26077b585050812755eb4e0b36e0e646dc7bcf024d2  update-extlinux"