class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.20.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.20.0/horus-v0.20.0-darwin-arm64.tar.gz"
      sha256 "5d07f6776086f446e79e5314c1a1c0d3f8101c94c62d7d9466c75f159e7524e0"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.20.0/horus-v0.20.0-darwin-x86_64.tar.gz"
      sha256 "3db4c9915c232543ff42b311f6ee2b6fb42721c01289b2fea711c53d182380bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.20.0/horus-v0.20.0-linux-arm64.tar.gz"
      sha256 "add9e445d46b6a7f8bd0fc405a5e76fad51e2aa9e62ee9fe6b2534dc0082bd1f"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.20.0/horus-v0.20.0-linux-x86_64.tar.gz"
      sha256 "f18134dd1e7da014b458898a59d6fdfd5a580ab0b20d42e368f4c007589f84a7"
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
