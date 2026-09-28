class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.23.0/horus-v0.23.0-darwin-arm64.tar.gz"
      sha256 "0a01888e6385d3f00d423e01db5f62fa160fcc4235de9b7fa02e70feee196d8b"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.23.0/horus-v0.23.0-darwin-x86_64.tar.gz"
      sha256 "0f7d0fdcc547db82bf4998f31c007dae4a5454a0ab25c80bf3b9fbc9ddaa5792"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.23.0/horus-v0.23.0-linux-arm64.tar.gz"
      sha256 "1afa19c0f8f50c7484d8cb593340b7873d8f10ea74c10a126e7b8a753581f747"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.23.0/horus-v0.23.0-linux-x86_64.tar.gz"
      sha256 "7a49c0ef1828daab0b933882303f52cdd5f8b7dd2d1591ac3c353b7ce385adbf"
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
