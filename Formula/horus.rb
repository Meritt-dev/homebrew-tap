class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.1/horus-v0.8.1-darwin-arm64.tar.gz"
      sha256 "c9b67233f807dfce44dfa63307d26de4ae97d7a0ebae67279bdd105d8173b791"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.1/horus-v0.8.1-darwin-x86_64.tar.gz"
      sha256 "10ba8a8553c8fe3a48a8a7994c2d91671366fec55c5d8c6e02c5e7d26547f7b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.1/horus-v0.8.1-linux-arm64.tar.gz"
      sha256 "b6fb6df583500a9acbaed148bc18d65953ebc0b1642b19e23e4890b161474b49"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.1/horus-v0.8.1-linux-x86_64.tar.gz"
      sha256 "2c89d8a87b5849e78d1e97c9404c9b612798028fbad3fa91df36d72e6321843b"
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
