class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.20"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.20/horus-v0.8.20-darwin-arm64.tar.gz"
      sha256 "9a724cf1459bb996d941f23e7ca1e95c8e9c0730aaebdf9a13ff220811c2792e"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.20/horus-v0.8.20-darwin-x86_64.tar.gz"
      sha256 "3580e65eaec1757a3bc641922f10d28f51c9dd30d64439c110cb44cab200ec37"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.20/horus-v0.8.20-linux-arm64.tar.gz"
      sha256 "c27530836e5df9f2e035a534a3ff62c636706b693d81a8bfde413a3166a90df4"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.20/horus-v0.8.20-linux-x86_64.tar.gz"
      sha256 "3cd2f1042924a0d89cc066ca1da7801c703dd555f3d633f283cbec675169bce2"
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
