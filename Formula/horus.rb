class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.9"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.9/horus-v0.8.9-darwin-arm64.tar.gz"
      sha256 "c707c030d030628d88a85ed84f125cbc6b28a36946c64a20cd48b203cd4f9e61"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.9/horus-v0.8.9-darwin-x86_64.tar.gz"
      sha256 "fd84b6379e39ac810cb058c3ed511602d7bd9bb2e10a449b003f09105b645738"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.9/horus-v0.8.9-linux-arm64.tar.gz"
      sha256 "6432bd0d892d015b02defed35a0943c892d34b4b4be20cbe638968e2c49d860d"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.9/horus-v0.8.9-linux-x86_64.tar.gz"
      sha256 "1e81b3fa6fce1d30a8804de780f5ba6449bf934bd80872966bea70f13893f3b0"
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
