TERMUX_PKG_HOMEPAGE=https://github.com/microsoft/vscode
TERMUX_PKG_DESCRIPTION="VS Code language servers"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.101.2
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/microsoft/vscode/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=d65d04e68ae04a372b1c6b13d0e8a72e2c919e491d4c3b2dcf997b22fc25a509
TERMUX_PKG_DEPENDS="nodejs"
TERMUX_PKG_BUILD_DEPENDS="nodejs"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_HAS_DEBUG=false

termux_step_configure() {
  for i in css html json; do
    pushd "extensions/$i-language-features/server"
    npm ci
    npm i typescript
    popd
  done
}

termux_step_make() {
  for i in css html json; do
    pushd "extensions/$i-language-features/server"
    tsc || true
    popd
  done
}

termux_step_make_install() {
  local _pkgdir
  _pkgdir="$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX"
  install -d "$_pkgdir/bin"
  for i in css html json; do
    local _lib_pkgdir
    _lib_pkgdir="$_pkgdir/lib/node_modules/vscode-$i-languageserver"
    install -d "$_lib_pkgdir"
    printf '%s\n' "#!/${TERMUX_PREFIX}/bin/env node" "require('${TERMUX_PREFIX}/lib/node_modules/vscode-$i-languageserver/out/node/${i}ServerMain');" >"${_pkgdir}/bin/vscode-${i}-language-server"
    chmod +x "$_pkgdir/bin/vscode-$i-language-server"
    local _lib_srcdir
    _lib_srcdir="$TERMUX_PKG_SRCDIR/extensions/$i-language-features/server"
    cp -r "$_lib_srcdir/out" "$_lib_srcdir/node_modules" "$_lib_srcdir/package.json" "$_lib_pkgdir/"
    rm -r "$_lib_pkgdir/node_modules/@types"
  done
}

termux_step_install_license() {
  local _pkgdir
  _pkgdir="$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX"
  for i in css html json; do
    install -Dm644 -t "$_pkgdir/share/licenses/vscode-$i-language-server" "$TERMUX_PKG_SRCDIR/LICENSE.txt"
  done
}

termux_step_copy_into_massagedir() {
  return
}
