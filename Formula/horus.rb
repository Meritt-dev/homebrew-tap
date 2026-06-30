class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.18.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.18.0/horus-v0.18.0-darwin-arm64.tar.gz"
      sha256 "f91e5f6eedbb22aef790ab3029ffaeb9db34df4b0c8e2e7ee78ca309b26f0afe"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.18.0/horus-v0.18.0-darwin-x86_64.tar.gz"
      sha256 "a26612dcf0a0d39e554756470e7fb507b6e691d25c2375cbc5c5724024e976aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.18.0/horus-v0.18.0-linux-arm64.tar.gz"
      sha256 "ec1397334605a644e9b976d3f81909fdf626f992ca9eab714f91c4977ea83e9e"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.18.0/horus-v0.18.0-linux-x86_64.tar.gz"
      sha256 "0326b803e4d90ff091add7fa54a0cacf48e430b1733068628a9ffe64d804b183"
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
