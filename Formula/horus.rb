class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.11.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.11.0/horus-v0.11.0-darwin-arm64.tar.gz"
      sha256 "d8127ec738bf95ac0a828f8c043d2b5630c743ee9397eee17eb58d2288e8b170"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.11.0/horus-v0.11.0-darwin-x86_64.tar.gz"
      sha256 "48628b611a7f6ce81dfaeea4c097a64817fba2d4dba2080680ad933e5a206133"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.11.0/horus-v0.11.0-linux-arm64.tar.gz"
      sha256 "dbdb96151804dce463ed404229f08ab68eb30898d8f959eae2a9de942c4e5889"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.11.0/horus-v0.11.0-linux-x86_64.tar.gz"
      sha256 "a06c0ecfde368a2dc2e0d7487fd13a9b101b8a5134a4163d8ca1eadb12f8f775"
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
