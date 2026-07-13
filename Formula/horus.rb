class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.9"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.9/horus-v0.21.9-darwin-arm64.tar.gz"
      sha256 "d7b711bafd0b8d86316c27e8925e5ee9a68f16a5582170ca8f948741722ed2f7"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.9/horus-v0.21.9-darwin-x86_64.tar.gz"
      sha256 "62363bdaf7fd0a047d3b988b91248422bb0d2381556bfae682b741660ec01d0d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.9/horus-v0.21.9-linux-arm64.tar.gz"
      sha256 "b21a86cb9a451053030d68849a6150c5026d9aa4c1bab6c6a8a0ac33e660ebab"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.9/horus-v0.21.9-linux-x86_64.tar.gz"
      sha256 "a91ee80dbf8c19c635197c7c7cd46cb0b498e630ff64c18e2e50192954a3582d"
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
