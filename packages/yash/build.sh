TERMUX_PKG_HOMEPAGE="https://magicant.github.io/yash/"
TERMUX_PKG_DESCRIPTION="A POSIX-compliant command line shell"
TERMUX_PKG_LICENSE="GPL-2.0-only"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.61
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/magicant/yash/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=06401f8abfad7ac3bdbce66ccda2c37878fa103a53a3c3ed35e386f2514dd9bd
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
