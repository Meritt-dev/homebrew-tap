class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.5"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.5/horus-v0.8.5-darwin-arm64.tar.gz"
      sha256 "093ab6cbf2ee7bde478429dc243362cd5b99e72d8ca89c0993bd8c8c0cbd7aa0"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.5/horus-v0.8.5-darwin-x86_64.tar.gz"
      sha256 "c8ef53f591d20888655dbf0a51e40705145f73de4dc499c0b9d95a8481b397c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.5/horus-v0.8.5-linux-arm64.tar.gz"
      sha256 "1ac549a903b75aca39970f8351bccf38095fe6ab9f17b9d7e8e3bad55f975444"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.5/horus-v0.8.5-linux-x86_64.tar.gz"
      sha256 "36e6557e5dbb402ce8b4a23bb5f789c541f1da8c2269e6af338d37586c8e03a6"
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
