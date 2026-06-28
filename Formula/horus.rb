class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.12.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.1/horus-v0.12.1-darwin-arm64.tar.gz"
      sha256 "0526c020c008b3b826de3d4f37b4511dbef6645bbffc7c0f0bb0bef6afe4ce1c"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.1/horus-v0.12.1-darwin-x86_64.tar.gz"
      sha256 "8be2b7620d685480dfbc605dda124ac0d51ed116db2a0ea1eff8d0367977a008"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.1/horus-v0.12.1-linux-arm64.tar.gz"
      sha256 "d6d66296b6504738e987d03f6e09cf893935a1dedd64b7e6e0cd8f56a4e382ae"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.1/horus-v0.12.1-linux-x86_64.tar.gz"
      sha256 "ab863b1d304f78aa4f4d0d175e6b5aa6b1ce53de4ecb2c42698f0de72cfd9cef"
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
