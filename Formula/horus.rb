class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.15.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.0/horus-v0.15.0-darwin-arm64.tar.gz"
      sha256 "72e765a055985104dbc2c667f9883b7f3a28e66a3c49a5bf6e552577801e90e8"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.0/horus-v0.15.0-darwin-x86_64.tar.gz"
      sha256 "9795ffef1159f9620ab418573b908105ed07ea849d574e5b6f522d5ea1a7bd49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.0/horus-v0.15.0-linux-arm64.tar.gz"
      sha256 "25a736333bfd1d68e14de2eadb8740686f81220336ecde9663c5ca6d93ffa99d"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.0/horus-v0.15.0-linux-x86_64.tar.gz"
      sha256 "a102d0018584ecdeda97f28ad1713317dc6207cd1e0b33a1679c903ac44b165a"
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
