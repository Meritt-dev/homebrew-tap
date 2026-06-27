class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.17"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.17/horus-v0.8.17-darwin-arm64.tar.gz"
      sha256 "09b5159aa5c056d5fd3f08d22d37a926d0501eb0b2e5c69f2a149f5fbba294e9"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.17/horus-v0.8.17-darwin-x86_64.tar.gz"
      sha256 "3f8ff59b4c68a8e348c5874907a36cb835053af3520e374bd2af539782186757"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.17/horus-v0.8.17-linux-arm64.tar.gz"
      sha256 "bc0e79ce60d4746f7bee2fd9a943987ee585e102c47f3ef27dcc5260dd947642"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.17/horus-v0.8.17-linux-x86_64.tar.gz"
      sha256 "ae399873dd3a621b97a9eacd6bc60c2546082cfba4cae4bc282cf08881a040ad"
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
