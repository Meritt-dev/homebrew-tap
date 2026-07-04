class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.6"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.6/horus-v0.21.6-darwin-arm64.tar.gz"
      sha256 "d87a8569f1d1a4aa2b5dc496de2b08d991f841a7cdbc9247f0016ea870ef0030"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.6/horus-v0.21.6-darwin-x86_64.tar.gz"
      sha256 "ada25a8e0ed2d80324287036dfb0988f1b6206c745e279a5713276c57fa418c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.6/horus-v0.21.6-linux-arm64.tar.gz"
      sha256 "5c70ff951f5721f93f4e3d04092f05ef0314c61822b38481dab9b687e1034d56"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.6/horus-v0.21.6-linux-x86_64.tar.gz"
      sha256 "dc11b0c2e688328833936b058389517a81e8cad26834363e00d8067d88153846"
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
