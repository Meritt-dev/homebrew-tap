class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.2"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.2/horus-v0.8.2-darwin-arm64.tar.gz"
      sha256 "6e211a8cc9f9dc026bedb485ff79718b975ab85083487214358edd24715b44aa"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.2/horus-v0.8.2-darwin-x86_64.tar.gz"
      sha256 "5ac3facd7e6e026e429b6400076fb9aba24427b284bc343458d0a684c1ab2ecd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.2/horus-v0.8.2-linux-arm64.tar.gz"
      sha256 "de52aafea61ee3c4d9d7c5bdc90c7eb7278698d53d020bfc27a60c46dc7f5b84"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.2/horus-v0.8.2-linux-x86_64.tar.gz"
      sha256 "b0076dfb5289e18479348819d55d01f696a16a81ccc8e2df0c18a5e80832e114"
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
