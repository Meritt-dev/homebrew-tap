class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.7"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.7/horus-v0.21.7-darwin-arm64.tar.gz"
      sha256 "773a7c45e119c25c9fd3e5fe67a837e226c0977b6a8e52ef522e665d57a901a0"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.7/horus-v0.21.7-darwin-x86_64.tar.gz"
      sha256 "7c8c1065f0079a7bcde7a3939c2af0f54edf97808e5bfdef055a185ecaf803ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.7/horus-v0.21.7-linux-arm64.tar.gz"
      sha256 "b347aad1e1696a7c15f512db305aa0b925f44f6ffb4723e458377129543565fb"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.7/horus-v0.21.7-linux-x86_64.tar.gz"
      sha256 "4d25b012b7c095747f31fcc5ca1fc498e5f715e7c854ee42fdd5faf90e0fdbbf"
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
