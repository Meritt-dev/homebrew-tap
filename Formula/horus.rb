class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.8"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.8/horus-v0.8.8-darwin-arm64.tar.gz"
      sha256 "2ef5ab00e7c16c80590cdd00c8a35a13934c6a1d1ae2047ada9aa151ab2a6f4d"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.8/horus-v0.8.8-darwin-x86_64.tar.gz"
      sha256 "97b55e7a66f185c8713e8c39a93d4c763ea808cda590a7819f4bcf69871ab808"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.8/horus-v0.8.8-linux-arm64.tar.gz"
      sha256 "af16f1c644a4317129ca57284c17b4c0c60d89ed4988331f91461b6a5c978c1e"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.8/horus-v0.8.8-linux-x86_64.tar.gz"
      sha256 "1d46f4481b2e83079342918e0544fc6294e7bb939cb137329454f012cf294f51"
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
