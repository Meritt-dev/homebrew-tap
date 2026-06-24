class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.4"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.4/horus-v0.8.4-darwin-arm64.tar.gz"
      sha256 "b2df4a1c20b0d7aa91b915740d42fe3b66af9bf05d866e952ab6a3aeb8307ac7"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.4/horus-v0.8.4-darwin-x86_64.tar.gz"
      sha256 "fb488bbb16c5c633218744c07d7b4a940d73e7f8b476b95a53e1716cb74b1ed3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.4/horus-v0.8.4-linux-arm64.tar.gz"
      sha256 "31a1c887652be4510f0b7e37dc612b4c43d7745b24b496cb34821d7f3a431a47"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.4/horus-v0.8.4-linux-x86_64.tar.gz"
      sha256 "71462086e1e06f1a2a20611140485010ca37d0cd142e5f5c9198362a448294dd"
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
