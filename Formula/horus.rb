class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.14"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.14/horus-v0.8.14-darwin-arm64.tar.gz"
      sha256 "add0e3096e3c528094e23263e44749dee9a34fa337643bb3e1c309c0fce80e3b"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.14/horus-v0.8.14-darwin-x86_64.tar.gz"
      sha256 "f98144b4e974c417648b714430a3117591b175c96f9c981be05caaa8368a2a4d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.14/horus-v0.8.14-linux-arm64.tar.gz"
      sha256 "3bb5fd5c857a79ad5f0baa3d0163b72af0c3da54a9270c8c8d0684a01b56fd03"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.14/horus-v0.8.14-linux-x86_64.tar.gz"
      sha256 "3bb5fd5c857a79ad5f0baa3d0163b72af0c3da54a9270c8c8d0684a01b56fd03"
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
