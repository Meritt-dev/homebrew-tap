class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.12.2"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.2/horus-v0.12.2-darwin-arm64.tar.gz"
      sha256 "4af32a7c605b9b7c23f70e46c67e1d8c74c10c78c4d6765edc4a02990bf2c984"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.2/horus-v0.12.2-darwin-x86_64.tar.gz"
      sha256 "4bc03d838526de15930aca7740f7ef8aa29f0e8802f5dff74170fc7c2d3a02f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.2/horus-v0.12.2-linux-arm64.tar.gz"
      sha256 "72aecfbaa06c544155d4b161268b6c506b0188bfea4f75476b12a34ef3e8dca0"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.2/horus-v0.12.2-linux-x86_64.tar.gz"
      sha256 "743c770ce7051b716b1c39e21b126a8ad82c80eb29498e35d37ff6fe25f9dd06"
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
