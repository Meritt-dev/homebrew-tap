class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.14.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.14.1/horus-v0.14.1-darwin-arm64.tar.gz"
      sha256 "db786ec3c7f7a200cb6615f2de67d79ac67c102a922ddbdb36ebfcb78d3b8788"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.14.1/horus-v0.14.1-darwin-x86_64.tar.gz"
      sha256 "e8eac78dfb34c23ac295371ca1625ceebe4cdb98061d014f24a024f4fd61797f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.14.1/horus-v0.14.1-linux-arm64.tar.gz"
      sha256 "f8158d30d89a986e9cbdaefd252ec3bb7f5fbbde25d25d8998d5e771c4df6173"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.14.1/horus-v0.14.1-linux-x86_64.tar.gz"
      sha256 "3beed57e82d19d654c751357b74c988f36096388f1dd686c30283ad67a8e342b"
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
