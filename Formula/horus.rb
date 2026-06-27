class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.18"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.18/horus-v0.8.18-darwin-arm64.tar.gz"
      sha256 "e4508c70a7791e0d438d830900cf9b52f1908b2c8f22cb6038a164f95ce1c6bf"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.18/horus-v0.8.18-darwin-x86_64.tar.gz"
      sha256 "134cf42e59c96dcabcf250b974e0a9f61d649d193cefbc87da33be7d823d4efd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.18/horus-v0.8.18-linux-arm64.tar.gz"
      sha256 "3a8c5009f59c7f267a0fa1bdbbab5f0fb729df84fd189e17a94bd6f5b4898f49"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.18/horus-v0.8.18-linux-x86_64.tar.gz"
      sha256 "0c1e044862089a419963531d0127974bfb88666ea44b08a73fd4d31863f709fc"
    end
  end

  def install
    # The binary loads pglite's WASM/FS assets via new URL('./pglite.wasm',
    # import.meta.url), which resolves relative to the binary's RESOLVED path. Install
    # the binary and its sibling assets together in libexec, then symlink into bin --
    # Node resolves the symlink before evaluating import.meta.url, so it finds the
    # siblings in libexec. (If the assets are absent, the CLI degrades to display-only.)
    libexec.install Dir["libexec/*"]
    bin.install_symlink libexec/"horus"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/horus --version")
    assert_match "Usage: horus", shell_output("#{bin}/horus --help")
  end
end
