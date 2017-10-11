# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/lunixbochs/glues"
EGIT_BRANCH="glu"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
fi

inherit cmake-utils cmake-multilib multilib ${GIT_ECLASS}

DESCRIPTION="The OpenGL Utility Library"
HOMEPAGE="https://cgit.freedesktop.org/mesa/glu/"

SRC_URI=""
KEYWORDS="amd64"

SLOT="0"

DEPEND=">=virtual/opengl-7.0-r1[${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}
	!<media-libs/mesa-9"

src_unpack() {
	default
	[[ $PV = 9999* ]] && git-2_src_unpack
}

src_install() {
	_cmake_check_build_dir
    dolib.so  ${BUILD_DIR}/libGLU.so.1
	insinto /usr/include/GL
	doins ${S}/source/glues.h
	doins ${S}/source/glu.h
	insinto /usr/lib/pkgconfig
	doins ${S}/glu.pc
}
