class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.15.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.1/horus-v0.15.1-darwin-arm64.tar.gz"
      sha256 "41ee793ac7218ce663d643426c6c0484ef3fe047396ca7cd6ff5bbf73b298285"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.1/horus-v0.15.1-darwin-x86_64.tar.gz"
      sha256 "47d517022760798b54d91978d776dcf393caaed35ae7b7d14c0059c81be32956"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.1/horus-v0.15.1-linux-arm64.tar.gz"
      sha256 "6ae62bdc5aa888a4b459570543167200c54c236af36d15f18fceefce828eb31c"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.1/horus-v0.15.1-linux-x86_64.tar.gz"
      sha256 "9d3ab23967a0c77b23ad37d76e4c9c887b08702003325a84f31264fedd7fe72d"
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
