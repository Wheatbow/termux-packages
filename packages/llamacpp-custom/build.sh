TERMUX_PKG_HOMEPAGE=https://github.com/ggml-org/llama.cpp
TERMUX_PKG_DESCRIPTION="LLM inference in C/C++"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
__VERSION="b8204"
TERMUX_PKG_VERSION=0.0.0-${__VERSION}
TERMUX_PKG_SRCURL=https://github.com/ggml-org/llama.cpp/archive/refs/tags/${TERMUX_PKG_VERSION#*-}.tar.gz
TERMUX_PKG_SHA256="SKIP_CHECKSUM"
TERMUX_PKG_BUILD_DEPENDS="vulkan-headers, shaderc, opencl-headers"
TERMUX_PKG_CONFLICTS="llama-cpp, llama-cpp-backend-vulkan, llama-cpp-backend-opencl"
TERMUX_PKG_REPLACES="llama-cpp, llama-cpp-backend-vulkan, llama-cpp-backend-opencl"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DHEXAGON_SDK_ROOT=$XDG_DATA_HOME/hexagon-sdk/6.4.0.2 \
-DLLAMA_BUILD_TESTS=OFF \
-DGGML_VULKAN=ON \
-DGGML_OPENCL=ON \
-DGGML_HEXAGON=OFF \
-DGGML_OPENMP=OFF"

termux_step_make_install() {
  local _pkgdir
  _pkgdir="$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX"
  mkdir -p "$_pkgdir/bin" "$_pkgdir/lib"
  cp "$TERMUX_PKG_BUILDDIR"/bin/*.so "$_pkgdir/lib"
  cp "$TERMUX_PKG_BUILDDIR"/bin/llama* "$_pkgdir/bin"
}

termux_step_copy_into_massagedir() {
  return
}
