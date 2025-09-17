TERMUX_PKG_HOMEPAGE="https://magicant.github.io/yash/"
TERMUX_PKG_DESCRIPTION="A POSIX-compliant command line shell"
TERMUX_PKG_LICENSE="GPL-2.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.60
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/magicant/yash/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=15574a494fde1f90d95c1c659bf834c2d91ea4948dcfd055cac89c70ec5568f5
TERMUX_PKG_BUILD_DEPENDS="asciidoc"
TERMUX_PKG_DEPENDS="ncurses"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
  ./configure --prefix="$TERMUX_PREFIX"
}

termux_step_make_install() {
  local _pkgdir
  _pkgdir="$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX"
  mkdir -p "$_pkgdir/bin"
  cp "$TERMUX_PKG_SRCDIR/yash" "$_pkgdir/bin"
}

termux_step_copy_into_massagedir() {
  return
}
