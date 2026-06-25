class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.6"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.6/horus-v0.8.6-darwin-arm64.tar.gz"
      sha256 "1da2b298d0fcf8a18e5e44e2c8e5e971789d0ac6dc10e0b40343a31c757b248a"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.6/horus-v0.8.6-darwin-x86_64.tar.gz"
      sha256 "34fa6233f094df2bd5958ea72fcd3e160297858958d50e44efded3db053ce6fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.6/horus-v0.8.6-linux-arm64.tar.gz"
      sha256 "10edce66430e1f5bfa1420ffd553a8377fea9c1233fcfe0cef8c8d2999f5cab9"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.6/horus-v0.8.6-linux-x86_64.tar.gz"
      sha256 "3a87779654e14ef508f1d5fd2cfb1c9e579879e7e772b5c1403c47e88b999f39"
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
