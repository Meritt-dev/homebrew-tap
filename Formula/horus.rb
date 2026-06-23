class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.7.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.7.0/horus-v0.7.0-darwin-arm64.tar.gz"
      sha256 "167299eef311c8f12ae5d49c42d894f63ee74d7a8782d967c90fb67dd4a0f270"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.7.0/horus-v0.7.0-darwin-x86_64.tar.gz"
      sha256 "3bd32b51f143544f089b9ada982063b464cd532baf25fd80fab11ac493d50a84"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.7.0/horus-v0.7.0-linux-arm64.tar.gz"
      sha256 "6d6f948b9c1bf5ad03409b2abb88f11fb4959f59e7589e8dc97726569236449b"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.7.0/horus-v0.7.0-linux-x86_64.tar.gz"
      sha256 "0e39794ea4142032ae80a32289ab0f558ed862b70316445e806a7256b6d73600"
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
