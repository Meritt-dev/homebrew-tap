class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.2"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.2/horus-v0.21.2-darwin-arm64.tar.gz"
      sha256 "ace6e225dc6ebd8a1f23aa92f7d535fcaedf7cc27ee7c4c6ecd188135acf4a07"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.2/horus-v0.21.2-darwin-x86_64.tar.gz"
      sha256 "9da58019dc432541801888fda519dbbecddcfe0d86238aaa59fca946e3b48e67"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.2/horus-v0.21.2-linux-arm64.tar.gz"
      sha256 "100a762f3c501d03d416931b73483c0b7fa7b8bac62ecb3709dfbe55cbd80758"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.2/horus-v0.21.2-linux-x86_64.tar.gz"
      sha256 "e5363214ac1ab89fc3245c80821bf3a7f88a9724f5c7cc6afe896f2b0b4f8582"
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
