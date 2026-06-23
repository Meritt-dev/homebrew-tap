class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.0/horus-v0.8.0-darwin-arm64.tar.gz"
      sha256 "a95dccf2c16be3b6167c33bada32f00af56d41bd95f55184167d03c0da2fa0b2"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.0/horus-v0.8.0-darwin-x86_64.tar.gz"
      sha256 "0755eea28b73af88c2d6aad228ef53fde9e5c5af3b39b995599fdc7672006259"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.0/horus-v0.8.0-linux-arm64.tar.gz"
      sha256 "8842a7fb3efcbd094b6f7babd346005566a05e05999dd7c75b770c79eed8a423"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.0/horus-v0.8.0-linux-x86_64.tar.gz"
      sha256 "4733047be83c2660c5c0fcb1e81cb724b5c536a3289c8579d4bcf5a1151aee57"
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
