class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.12.5"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.5/horus-v0.12.5-darwin-arm64.tar.gz"
      sha256 "2586e5e2bedb73fd34cbab4d745916cc212e6dd6402464a8d42add6b208db8aa"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.5/horus-v0.12.5-darwin-x86_64.tar.gz"
      sha256 "f40fef6236c190565d39cfcbc2517e66d616107de67804ec037b06a2268474da"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.5/horus-v0.12.5-linux-arm64.tar.gz"
      sha256 "b247f2f77ca8beaf7e1709596cf4d82a695bcdc255126118fb8758776034ac0e"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.12.5/horus-v0.12.5-linux-x86_64.tar.gz"
      sha256 "8c274bdd0ecbd2a3826d67ec45e9b00d6d79fbe7a029ee6ecd4ceff5438f8bff"
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
