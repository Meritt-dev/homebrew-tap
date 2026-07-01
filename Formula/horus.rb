class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.19.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.19.0/horus-v0.19.0-darwin-arm64.tar.gz"
      sha256 "7c2325363fdcdd4bebf5c6332285c613d7f1fa1cbe92c502771224deb30eeaee"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.19.0/horus-v0.19.0-darwin-x86_64.tar.gz"
      sha256 "721bc066bfa26a3bdaa651efd727c5c06da128bd504e30f5dd445346d0677647"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.19.0/horus-v0.19.0-linux-arm64.tar.gz"
      sha256 "b8d6af78d970ea47a9fef229f30a60b7e02e2304dbc6f8ce5dd0794a6f3b53d9"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.19.0/horus-v0.19.0-linux-x86_64.tar.gz"
      sha256 "5641391eff7ca89660ebd1dd95f970e50796afd84124b7a8547f6434461fe9f7"
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
