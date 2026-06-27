class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.19"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.19/horus-v0.8.19-darwin-arm64.tar.gz"
      sha256 "1adadc8bae122db39270ea9903d86a8ee1fcf7af026aeef8bc43ac154d766b0d"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.19/horus-v0.8.19-darwin-x86_64.tar.gz"
      sha256 "7c5a6b4e8d10fa1baf8fe73abec593c67b8e1c49d28e138cacceca96c581c657"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.19/horus-v0.8.19-linux-arm64.tar.gz"
      sha256 "7a28cadbbb586411255bc8123910c8797ae43cd17bf2e65661e719ad3e8216b0"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.19/horus-v0.8.19-linux-x86_64.tar.gz"
      sha256 "d1188be7374a3f24994251a0d1bb42a04662b9a878afb7b1511076e9d82585ea"
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
