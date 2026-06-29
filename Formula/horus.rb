class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.12.4"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.4/horus-v0.12.4-darwin-arm64.tar.gz"
      sha256 "bb4a8cc9ebeec8f2addec4ba004a969217dd6b42379a39797255545460e7dfc6"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.4/horus-v0.12.4-darwin-x86_64.tar.gz"
      sha256 "2c38043a4b08d7c6b829fe2f7d0aab3447ec951e4c7ffc3b240c25df4ea108b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.4/horus-v0.12.4-linux-arm64.tar.gz"
      sha256 "2d77deb6a5d2e06374a52586e7410a0bfc3efe4a415d5f50d88a75694949bfca"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.4/horus-v0.12.4-linux-x86_64.tar.gz"
      sha256 "485df54fff263e84179d25714e4e8fe3ec03b9353b9ff882448f884bdfad8763"
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
