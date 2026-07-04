class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.5"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.5/horus-v0.21.5-darwin-arm64.tar.gz"
      sha256 "9bde90146004f1437554ec2fd3a8d6c03328fae610c7640a8aaa918793d7aec5"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.5/horus-v0.21.5-darwin-x86_64.tar.gz"
      sha256 "b32d751db0566fac44169e3f365dd4124cccf0e2e7c9d4137630524a6c8d265d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.5/horus-v0.21.5-linux-arm64.tar.gz"
      sha256 "1be059d1379c7c07ac765acd2fcd8053c255eb802f707811e8da957a42147791"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.5/horus-v0.21.5-linux-x86_64.tar.gz"
      sha256 "b136fd83ed71a5dc5aa1c67440996fc88d3385d438503a6f7984e1acfe523cd9"
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
