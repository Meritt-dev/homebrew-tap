class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.10.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.10.0/horus-v0.10.0-darwin-arm64.tar.gz"
      sha256 "0d18fbd6a73a0712e43628e38db4d1b4c7ca8e39cdf82c1a4c7a4213d515012c"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.10.0/horus-v0.10.0-darwin-x86_64.tar.gz"
      sha256 "80fc1e1e2a01a93ce6d7492b07b882c33c467ca4898d378dea57a4fe32058de4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.10.0/horus-v0.10.0-linux-arm64.tar.gz"
      sha256 "b476cdea508909642913b4e0e9b70d027e1d1ac37f023870b0404bdf30f4b8ed"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.10.0/horus-v0.10.0-linux-x86_64.tar.gz"
      sha256 "bae47b90180368ddc7f689a3be546bf252bef971ccd3a2f91cdb4d397bc93961"
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
