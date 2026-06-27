class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.15"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.15/horus-v0.8.15-darwin-arm64.tar.gz"
      sha256 "e5b154a9d1d50824c1e175279eac9aee0d5d35079a284a19dc13f4a1474d67ab"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.15/horus-v0.8.15-darwin-x86_64.tar.gz"
      sha256 "f6da47c646be2bdf2c6358070edd4ea30774181fbf06616a48517d1bd74352a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.15/horus-v0.8.15-linux-arm64.tar.gz"
      sha256 "98a179dd64ea74e908125b2eba30bf03e1282f5e326f4fb28873add2f34cca1b"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.15/horus-v0.8.15-linux-x86_64.tar.gz"
      sha256 "8fac5c2f01c901bbf981746cd3162b741219fd47cb8901f2e968a271783425cc"
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
