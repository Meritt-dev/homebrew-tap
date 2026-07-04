class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.4"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.4/horus-v0.21.4-darwin-arm64.tar.gz"
      sha256 "760ab1ac7bbe64cebd73151bca823efec565f2f34f5d9eab922474f7657e3003"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.4/horus-v0.21.4-darwin-x86_64.tar.gz"
      sha256 "57dac4d4638566cbb474a5272e8d11521e0fce3335bf189b2885ceb91f93e961"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.4/horus-v0.21.4-linux-arm64.tar.gz"
      sha256 "d2074a6839392c680f938a31065bf9bb27e69446b16a9fc8a0294aa728c0becd"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.4/horus-v0.21.4-linux-x86_64.tar.gz"
      sha256 "98752dc860307551267b3f9aedff3b3c643eec0a7725431661a1caf0faa5db82"
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
