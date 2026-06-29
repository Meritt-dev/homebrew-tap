class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.13.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.1/horus-v0.13.1-darwin-arm64.tar.gz"
      sha256 "e1c21efc5fa2a79b6d563e64b0a2e6b1367d628ed963605596400c340fb7cbcc"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.1/horus-v0.13.1-darwin-x86_64.tar.gz"
      sha256 "9fbded2ff54276a740911589cd5dfd05c464730df9e523c294ec40c9d2fe88e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.1/horus-v0.13.1-linux-arm64.tar.gz"
      sha256 "cfbe0a35d19b0a978a74783620a9c0c5b0d30cae37b47b6b873253f025062848"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.1/horus-v0.13.1-linux-x86_64.tar.gz"
      sha256 "8b759d242f71f986c894427c44a5433de2a18c48e7da7a5fc3346860a270da55"
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
