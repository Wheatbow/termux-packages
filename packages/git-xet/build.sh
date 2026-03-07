TERMUX_PKG_HOMEPAGE=https://github.com/huggingface/xet-core/tree/main/git_xet
TERMUX_PKG_DESCRIPTION="A Git LFS custom transfer agent that implements upload and download of files using the Xet protocol"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.2.1
TERMUX_PKG_SRCURL=https://github.com/huggingface/xet-core/archive/refs/tags/git-xet-v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256="SKIP_CHECKSUM"
TERMUX_PKG_BUILD_DEPENDS="rust"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	cargo build -p git_xet --release
  local _pkgdir
  _pkgdir="$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX"
  mkdir -p "$_pkgdir/bin"
  cp "$TERMUX_PKG_BUILDDIR/target/release/git-xet" "$_pkgdir/bin"
}

termux_step_make_install() {
	return
}

termux_step_copy_into_massagedir() {
  return
}
