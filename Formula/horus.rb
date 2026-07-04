class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.3"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.3/horus-v0.21.3-darwin-arm64.tar.gz"
      sha256 "4982eea66d1a907e242354747cc5478830cc1761ed702b330cdaedefd1c6ec4c"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.3/horus-v0.21.3-darwin-x86_64.tar.gz"
      sha256 "ce44727c47196c75adb286d3ace84c4a1c96bc2810b52632e1df30b6975f569a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.3/horus-v0.21.3-linux-arm64.tar.gz"
      sha256 "89b68f2fd720f1201d85a8924cd1019ca91a0ce2bb71b8880eb786b90fdebdcd"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.3/horus-v0.21.3-linux-x86_64.tar.gz"
      sha256 "f313fd3521bfd57e13b2c8ac55273aae7d5f8c8a45e0cbe6b3d5bc2d63e651bf"
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
