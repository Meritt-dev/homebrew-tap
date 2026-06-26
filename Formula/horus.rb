class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.12"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.12/horus-v0.8.12-darwin-arm64.tar.gz"
      sha256 "21ba2d25a239aef0802e77355c05efe337c21427d05b797b54329ea4a7d569df"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.12/horus-v0.8.12-darwin-x86_64.tar.gz"
      sha256 "4a7e9dfc6d9c45384794e2a2687764cbbfc483125281538b24ecdad3f79931c6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.12/horus-v0.8.12-linux-arm64.tar.gz"
      sha256 "6e0c8e943767707e8738baf583caed4b9f2c8b2edb1f02dd84e1c19835babafa"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.12/horus-v0.8.12-linux-x86_64.tar.gz"
      sha256 "4142f9d543c2cd9160d31567d619db6883d345a4918e7d1e6fe6877acb8e517d"
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
