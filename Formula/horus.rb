class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.13"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.13/horus-v0.8.13-darwin-arm64.tar.gz"
      sha256 "621c75a46fa9f0072d2179173e61e84235d9c3a038efad0bae643b888ecb7589"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.13/horus-v0.8.13-darwin-x86_64.tar.gz"
      sha256 "d4a4bba9840b46e0e2cad650d98efd86c6e178c8e92fd863e4fca4c37108449e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.13/horus-v0.8.13-linux-arm64.tar.gz"
      sha256 "892d290531262ab189c1201f6506543b6ed62356b7cb7d04b7032f9c877ec258"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.13/horus-v0.8.13-linux-x86_64.tar.gz"
      sha256 "c53a3f2498499935665aa3652d2076a5b5744b6f66d9ebd1833e9b49515be9b3"
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
