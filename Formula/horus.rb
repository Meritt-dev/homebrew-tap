class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.16.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.16.1/horus-v0.16.1-darwin-arm64.tar.gz"
      sha256 "d3e422f5e62cbc4d6d1c63e3fed7e704442339546110b9b8b43fcf60999f89bc"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.16.1/horus-v0.16.1-darwin-x86_64.tar.gz"
      sha256 "1f77c83520346ce627c3e5664a2de50789755116467141987c28f782da7631e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.16.1/horus-v0.16.1-linux-arm64.tar.gz"
      sha256 "8101228d293d81fc72a8d06477c9675b96ab89e909c305e080eba56cb7cda421"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.16.1/horus-v0.16.1-linux-x86_64.tar.gz"
      sha256 "74ec6217d78626d6bb15f028d75418b9c48372efceb4023c897549c05a9aee0d"
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
