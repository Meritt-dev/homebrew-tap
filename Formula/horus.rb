class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.7"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.7/horus-v0.8.7-darwin-arm64.tar.gz"
      sha256 "3d0060c4c01c882d24d7b7d6b93f616bba98224a078407f1965c5c77dd6caa06"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.7/horus-v0.8.7-darwin-x86_64.tar.gz"
      sha256 "ca655fa27620d8c2d5d3340c1be999537a775f5f8bd5a6583f514a38813c6388"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.7/horus-v0.8.7-linux-arm64.tar.gz"
      sha256 "ac6f11b180317abbcd8085aa3f4db1f7d44e071da66ec7ece7e1e89bc39c97b8"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.7/horus-v0.8.7-linux-x86_64.tar.gz"
      sha256 "9417873fc7e3e65796ffb670b0c99804332de859f2df7277441df1418b815c2c"
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
