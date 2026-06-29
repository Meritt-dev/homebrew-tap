class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.13.2"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.2/horus-v0.13.2-darwin-arm64.tar.gz"
      sha256 "a91edc34b5234c9927edb08c88fd6639c92e7913f188c3129513383c4547bac1"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.2/horus-v0.13.2-darwin-x86_64.tar.gz"
      sha256 "2c31845d763d272ec4f56d2aceed3396c61c145c344bda103be03a891b0efc9e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.2/horus-v0.13.2-linux-arm64.tar.gz"
      sha256 "0c09ae15bc1dc073e1a9845dca9f71e2d27f05f1002f0c5dc99b690fa8842338"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.2/horus-v0.13.2-linux-x86_64.tar.gz"
      sha256 "8f0d21f3cb450f04b356ed85890bae42280fa1b0d50a3b2c22bb914f5d3dce27"
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
