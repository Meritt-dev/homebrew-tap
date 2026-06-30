class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.14.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.14.0/horus-v0.14.0-darwin-arm64.tar.gz"
      sha256 "838c6cf66438926dbb141a88a1577bd1f6c97b9412185bfa94d85c78468cdd19"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.14.0/horus-v0.14.0-darwin-x86_64.tar.gz"
      sha256 "3d0084ce2f718ac06d881a826b0c11160f1d17760df1e642427d4f6942de7b86"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.14.0/horus-v0.14.0-linux-arm64.tar.gz"
      sha256 "823d02e6dd1806015a4b61d126fe1f87e0321dfc292e0e71f7e0a480c4e1bae8"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.14.0/horus-v0.14.0-linux-x86_64.tar.gz"
      sha256 "a67d8df027f429af0461db3473d9ae2c33756cb252c09e5d420a5ffafa838caa"
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
