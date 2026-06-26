class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.11"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.11/horus-v0.8.11-darwin-arm64.tar.gz"
      sha256 "4895870338ae634b30f0cf27b2bae85d4e249a51fa7c9285f4b13d6a3cfa3535"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.11/horus-v0.8.11-darwin-x86_64.tar.gz"
      sha256 "68c901993b378c89210861084024f72342bc1fc3e412912897945c8021cb8437"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.11/horus-v0.8.11-linux-arm64.tar.gz"
      sha256 "219331d80eb170c524495995ef2988d36b5e282a18dcfaf1a97fc95173b64090"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.11/horus-v0.8.11-linux-x86_64.tar.gz"
      sha256 "ac05c1c88f26d8e18792e58f8219d7db9ab4bf15f22312134bdf0590d38a5872"
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
