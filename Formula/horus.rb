class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.3"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.3/horus-v0.8.3-darwin-arm64.tar.gz"
      sha256 "37c5640c59483ae32f2930ae15b0da912d9e759b6964988f93a74b71fe74c2e5"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.3/horus-v0.8.3-darwin-x86_64.tar.gz"
      sha256 "0c5593b69e294507701fd099f73cc0fedcfdeb61dd28d3214fe86793d528ece7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.3/horus-v0.8.3-linux-arm64.tar.gz"
      sha256 "8238acf93f1c211476d8ae48ccd093e82e5e8c7463ff8fdd7400eaa542d69e9b"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.3/horus-v0.8.3-linux-x86_64.tar.gz"
      sha256 "53b1be9daee0800f1d8ffb64f8b327c0ed6270a334789af537a620c7581104fe"
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
