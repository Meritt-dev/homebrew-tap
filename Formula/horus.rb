class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.17.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.17.1/horus-v0.17.1-darwin-arm64.tar.gz"
      sha256 "f5b4af4394ef135bf902c6dabf46e314d1f8e49c91caa0999298fe07ceba11a8"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.17.1/horus-v0.17.1-darwin-x86_64.tar.gz"
      sha256 "69bfbd8879d4b7c0123c5cc060f08ea3ac0a1e5918e184725fbf7b3d905345b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.17.1/horus-v0.17.1-linux-arm64.tar.gz"
      sha256 "72ea357f3deb9e696d9175cce5486354c5de6e00a59f04bd8e2088659cc2cb54"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.17.1/horus-v0.17.1-linux-x86_64.tar.gz"
      sha256 "82270d1e60db97b1765d7d4d8f75a34565f9925113d1e41516c36269d097c5ff"
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
