class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.8"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.8/horus-v0.21.8-darwin-arm64.tar.gz"
      sha256 "c21129656f51a24d3bc1ebfe0a7f190b09af8b002d126e03b009706059f1c97e"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.8/horus-v0.21.8-darwin-x86_64.tar.gz"
      sha256 "fe8f45c6b81c9cc385710f995addf2d3b78892b0fc6499cafdedb395271f75df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.8/horus-v0.21.8-linux-arm64.tar.gz"
      sha256 "868be49c83a76e25eb4c23de0265663c72fdbb2eb6e03eee595797ed5cdfa8bd"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.8/horus-v0.21.8-linux-x86_64.tar.gz"
      sha256 "4c20177685e4e81e3e214a961df91e63c8ac05056d4b8111aa348e0bbe2e1839"
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
