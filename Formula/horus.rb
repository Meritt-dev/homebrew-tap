class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.16.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.16.0/horus-v0.16.0-darwin-arm64.tar.gz"
      sha256 "19964842d00466b44b152c73edba28ee563e1b49850846f0c6c148f9394f0253"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.16.0/horus-v0.16.0-darwin-x86_64.tar.gz"
      sha256 "79459dd8e282fad82feab574384078ffbc3344343a7136cd278eda9003326bc7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.16.0/horus-v0.16.0-linux-arm64.tar.gz"
      sha256 "43406b44f93eba0a39e4ee0f55116eb8a665a4d39c0da118a701709b485247d2"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.16.0/horus-v0.16.0-linux-x86_64.tar.gz"
      sha256 "a0c07df58e7956b1a04f15a6a0e4ad86cbfaa1550de128ac8ab2ce66b924f386"
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
