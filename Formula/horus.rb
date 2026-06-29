class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.12.3"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.3/horus-v0.12.3-darwin-arm64.tar.gz"
      sha256 "7749190c35e0b2dfc28b84042fa8e03f8280eb101e8ff5849d3384cab14b3dbd"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.3/horus-v0.12.3-darwin-x86_64.tar.gz"
      sha256 "162d02ceae5cb0d4ed6f4eb1355595534fc5b00818d5d1b7ce0105db12d57e9f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.3/horus-v0.12.3-linux-arm64.tar.gz"
      sha256 "49c83ba27bf6e9e5934a3b38243e76f2f86019c6a6693b82f9a2afb7e885a1ce"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.3/horus-v0.12.3-linux-x86_64.tar.gz"
      sha256 "0a69aa0aedfef6735f4f42969fa3701587762617fbe1135b8da25b781af3499c"
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
