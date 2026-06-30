class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.15.2"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.2/horus-v0.15.2-darwin-arm64.tar.gz"
      sha256 "4ac57ad311be29059ed50070d0efb9e1c2166329da5274eecfbb3cd7306d494c"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.2/horus-v0.15.2-darwin-x86_64.tar.gz"
      sha256 "cd80ef388e5bec836701a5478aa614cc64f465f6c449e3649abf50266ec264f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.2/horus-v0.15.2-linux-arm64.tar.gz"
      sha256 "653fca8bf79c92dd3a795c58b20bc4b0798348c9e56ae84f4b9beb80bf5bfe2f"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.15.2/horus-v0.15.2-linux-x86_64.tar.gz"
      sha256 "09202d558cc75f337420302c8295985bc5cefb7f9d235ae7c059c8b7b5e21a26"
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
