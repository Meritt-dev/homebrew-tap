class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.17.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.17.0/horus-v0.17.0-darwin-arm64.tar.gz"
      sha256 "6dc19108bc46d6989e66eb05b97fb43dc1d39cce28b5d6bf880dea636fd71872"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.17.0/horus-v0.17.0-darwin-x86_64.tar.gz"
      sha256 "58af6dfc1a176e21d6cd88d195340fc2ab8e153a9e369e45babf300fa7ea7384"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.17.0/horus-v0.17.0-linux-arm64.tar.gz"
      sha256 "7d258a0dc1a4c0b64bf6cc7fc5844fd0f46e9f85d043799d3f6918b9426eb104"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.17.0/horus-v0.17.0-linux-x86_64.tar.gz"
      sha256 "3701fc01ac7bc04a546b838786cc78b5645b5f2571890957694d750cd4cd0f98"
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
