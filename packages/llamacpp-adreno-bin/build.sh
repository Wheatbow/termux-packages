TERMUX_PKG_HOMEPAGE=https://github.com/ggml-org/llama.cpp
TERMUX_PKG_DESCRIPTION="LLM inference in C/C++ (Snapdragon Adreno prebuilt)"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.0.0-b11517"
TERMUX_PKG_SRCURL=https://github.com/ggml-org/llama.cpp/releases/download/${TERMUX_PKG_VERSION#*-}/llama-${TERMUX_PKG_VERSION#*-}-bin-android-arm64-snapdragon.tar.gz
TERMUX_PKG_SHA256=66e61157f4e3d98046f3c6f9c2bae2a402014d68b1db210988b931988e5fd55c
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="ocl-icd"
TERMUX_PKG_CONFLICTS="llama-cpp, llama-cpp-backend-vulkan, llama-cpp-backend-opencl, llamacpp-adreno"
TERMUX_PKG_REPLACES="llama-cpp, llama-cpp-backend-vulkan, llama-cpp-backend-opencl, llamacpp-adreno"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make_install() {
	install -Dm700 -t "$TERMUX_PREFIX/bin" "$TERMUX_PKG_SRCDIR"/bin/llama*
	install -Dm600 -t "$TERMUX_PREFIX/lib" "$TERMUX_PKG_SRCDIR"/lib/lib*.so

	# Official binaries have no RUNPATH, so they cannot find their own
	# libs in $PREFIX/lib nor libOpenCL.so from ocl-icd. Fix that.
	# shellcheck disable=SC2086
	for f in "$TERMUX_PREFIX"/bin/llama* "$TERMUX_PREFIX"/lib/lib*.so; do
		[ -f "$f" ] || continue
		# Skip Hexagon DSP blobs (32-bit QDSP6 ELF, not AArch64).
		# patchelf segfaults on them and they must not get an AArch64 RUNPATH.
		case "$(basename "$f")" in
			libggml-htp-*.so) continue ;;
		esac
		patchelf --set-rpath "$TERMUX_PREFIX/lib" "$f"
	done
}
