TERMUX_PKG_HOMEPAGE=https://github.com/leejet/stable-diffusion.cpp.git
TERMUX_PKG_DESCRIPTION="Stable Diffusion and Flux in pure C/C++"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
__VERSION="778-c00a9e9"
TERMUX_PKG_VERSION=0.0.0-${__VERSION}
TERMUX_PKG_GIT_BRANCH="master-${__VERSION}"
TERMUX_PKG_SRCURL=git+https://github.com/leejet/stable-diffusion.cpp
TERMUX_PKG_SHA256="SKIP_CHECKSUM"
TERMUX_PKG_BUILD_DEPENDS="vulkan-headers, shaderc, opencl-headers"
TERMUX_PKG_DEPENDS="libwebp"
TERMUX_PKG_CONFLICTS="sdcpp"
TERMUX_PKG_REPLACES="sdcpp"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DSD_OPENCL=ON \
-DSD_VULKAN=OFF \
-DSD_USE_SYSTEM_WEBP=ON \
-DGGML_NATIVE=OFF \
-DGGML_CPU_ARM_ARCH=armv8.6-a+dotprod+fp16+i8mm \
-DGGML_CPU_KLEIDIAI=ON \
-DGGML_OPENCL=ON \
-DGGML_OPENCL_USE_ADRENO_KERNELS=ON \
-DGGML_SCHED_NO_REALLOC=ON \
-DGGML_LTO=ON \
-DGGML_OPENMP=ON"

termux_step_make_install() {
  _pkgdir="$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX"
  mkdir -p "$_pkgdir/bin"
  cp "$TERMUX_PKG_BUILDDIR/bin/sd-cli" "$_pkgdir/bin/"
  cp "$TERMUX_PKG_BUILDDIR/bin/sd-server" "$_pkgdir/bin/"
}

termux_step_copy_into_massagedir() {
  return
}
