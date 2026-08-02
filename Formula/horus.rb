class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.22.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.22.0/horus-v0.22.0-darwin-arm64.tar.gz"
      sha256 "f47436720a571af6a2e111ce9b1b4846538ea237e5f4800754ad9674fbb0e7c3"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.22.0/horus-v0.22.0-darwin-x86_64.tar.gz"
      sha256 "44badb8473d5d9f8416bef5c85284f7b7da96e7362037835d4e9a33674aaf228"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.22.0/horus-v0.22.0-linux-arm64.tar.gz"
      sha256 "de594fb414d5c6071f133f105c32a80489c9defd1861b1241782155e696ee2e0"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.22.0/horus-v0.22.0-linux-x86_64.tar.gz"
      sha256 "4d85f0787c984fe9416e754f6b9d44a5b204f26da01e36eeb5315d473cc2af0c"
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
