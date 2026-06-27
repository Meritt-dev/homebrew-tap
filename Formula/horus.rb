class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.16"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.16/horus-v0.8.16-darwin-arm64.tar.gz"
      sha256 "0288d0ca716bff3de684d3ed12648c666697025dc068107dff0b8698a6d8d6b8"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.16/horus-v0.8.16-darwin-x86_64.tar.gz"
      sha256 "a8f1dd8937789f34897f576af70e63f5f44b3724a4a3e6aba34d8bc71ebb4586"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.16/horus-v0.8.16-linux-arm64.tar.gz"
      sha256 "2c7865196399baaa0039dff8bbd824eed750cf941ce56a07df0764f9298f2758"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.16/horus-v0.8.16-linux-x86_64.tar.gz"
      sha256 "e889fca1539ef059619e85be26109d758d88172cf8d30e71be71c8bb86f48f45"
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
