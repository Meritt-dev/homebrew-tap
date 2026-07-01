class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.19.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.19.1/horus-v0.19.1-darwin-arm64.tar.gz"
      sha256 "6cc8faa28e813c489411cc90c412b817f2cf1380ceb5d43669706c5ec0a406e0"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.19.1/horus-v0.19.1-darwin-x86_64.tar.gz"
      sha256 "9307d3c1310006c34e00515ef68d98febb0747123615d983c758f5dcf42568f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.19.1/horus-v0.19.1-linux-arm64.tar.gz"
      sha256 "1930d42d92c5ccbb5356dba73f5376d6404a6b1fa4fd2238d9fdbd0eddadb0a6"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.19.1/horus-v0.19.1-linux-x86_64.tar.gz"
      sha256 "fa7d4855e5973ce2723077f4948daf72521382a7cdf74feea6693f2c0e9f07a3"
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
