TERMUX_PKG_HOMEPAGE="https://magicant.github.io/yash/"
TERMUX_PKG_DESCRIPTION="A POSIX-compliant command line shell"
TERMUX_PKG_LICENSE="GPL-2.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.59
TERMUX_PKG_REVISION=1

TERMUX_PKG_SRCURL=https://github.com/magicant/yash/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=efe9d299a14d103d259b8a709fa2b664d8ff6ee498523f797f31f67db62e11af

TERMUX_PKG_BUILD_DEPENDS="asciidoc"
TERMUX_PKG_DEPENDS="ncurses"

TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
  ./configure --prefix="$TERMUX_PREFIX"
  
}
