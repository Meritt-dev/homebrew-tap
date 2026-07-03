class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.0/horus-v0.21.0-darwin-arm64.tar.gz"
      sha256 "bb00ea967941d1d1c8edf4b775fdda26e2a717fd2d74ad2f4f87a7348e7c7090"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.0/horus-v0.21.0-darwin-x86_64.tar.gz"
      sha256 "0b25003e75ae58445ff92a32db1ecd354a81d77c6dcfe5a6397dd5557c5f1faf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.0/horus-v0.21.0-linux-arm64.tar.gz"
      sha256 "0ecaa6d57e72663b7c37661aebf2017e82ecc15bd9d28c00d354fd2e798677cf"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.0/horus-v0.21.0-linux-x86_64.tar.gz"
      sha256 "5c1c22b2e6ac2f1685efc8d6f57bfcec76b35a402cbf5eaa75c85c4cff84c119"
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
