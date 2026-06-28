class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.9.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.9.0/horus-v0.9.0-darwin-arm64.tar.gz"
      sha256 "02d2fd4b14331586640c20cb7bd849da07fcc983cb8f0bf63a1627104d910d25"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.9.0/horus-v0.9.0-darwin-x86_64.tar.gz"
      sha256 "8e9fa5d8ca4f680c27b5c7b9e98eb120b0336403bbfe048240f89903e2f0525a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.9.0/horus-v0.9.0-linux-arm64.tar.gz"
      sha256 "1939b486d0b0437aa7cfe0fdab38c5a328d0c32215a6e0f2667de016f9484001"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.9.0/horus-v0.9.0-linux-x86_64.tar.gz"
      sha256 "316097409ce35a23d579d93a11119c566d28957f74481198bbd48fd6fc99fb68"
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
