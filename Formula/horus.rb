class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.13.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.0/horus-v0.13.0-darwin-arm64.tar.gz"
      sha256 "551a8edf29dc0b28d173800fd61bfae1996336a708ad0f2354ddb708a2627adc"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.0/horus-v0.13.0-darwin-x86_64.tar.gz"
      sha256 "982adab34f5980461461abb7d603f2933519b64ac04fdd1123d9ee00f4f07958"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.0/horus-v0.13.0-linux-arm64.tar.gz"
      sha256 "6ae41d7d31f70f4aff3c99ff7466af60532d1fce6df1b6ff8de9ec3ceb578608"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.13.0/horus-v0.13.0-linux-x86_64.tar.gz"
      sha256 "e5f4cbffdf7c5f5bb9c6ca7be5e24420a03e6ee47dc7fe946628b40bcd0ea7bf"
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
