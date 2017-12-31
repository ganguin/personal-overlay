# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils eutils toolchain-funcs

DESCRIPTION="Binary-decimal and decimal-binary conversion routines for IEEE doubles"
HOMEPAGE="https://github.com/google/double-conversion"
SRC_URI="https://github.com/google/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm ~arm64 hppa ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

LIBNAME=lib${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-scons.patch
}

src_compile() {
	sed -i -e "s/g++/$(tc-getCXX)/" SConstruct || die
	if use static-libs; then
	  cmake .
	else
	  cmake . -DBUILD_SHARED_LIBS=ON
	fi
	emake ${PN}
}

src_test() {
	eerror TODO cmake
}

src_install() {
	dolib.so src/${LIBNAME}.so*
	use static-libs && dolib.a ${LIBNAME}.a
	insinto /usr/include/double-conversion
	doins src/{double-conversion,utils}.h
	dodoc README Changelog AUTHORS
}
