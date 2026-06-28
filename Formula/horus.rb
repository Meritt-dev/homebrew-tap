class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.12.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.0/horus-v0.12.0-darwin-arm64.tar.gz"
      sha256 "d2aa0d7ca55e9b4da24cf4a842133b4f3bb9317b4fb82ca71302608896fbaa04"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.0/horus-v0.12.0-darwin-x86_64.tar.gz"
      sha256 "7707f5f01fde72414904f3627c5c1597abbb73e74fe7aa3e6d7f1002bffc69e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.0/horus-v0.12.0-linux-arm64.tar.gz"
      sha256 "175cc3d48cf4e8be96157597f0c3c2544efa430ff33a67c1994dc5bbfa233eaa"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.0/horus-v0.12.0-linux-x86_64.tar.gz"
      sha256 "7f06ce0610edc8a0320edd00f5508695429de85a94e5c715637e9dec18bb3026"
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
