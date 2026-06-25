class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.8.10"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.10/horus-v0.8.10-darwin-arm64.tar.gz"
      sha256 "a2409373520677a969d13304891327a99e2b5e59b4d679c65d932a8d3a8abb5c"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.10/horus-v0.8.10-darwin-x86_64.tar.gz"
      sha256 "358c5e530fb4f64e86db5a1db05b0c9a5912051e73ee1beb3a74ed8c55b5ca0f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.10/horus-v0.8.10-linux-arm64.tar.gz"
      sha256 "068e9d458156c5b7191c9ed7e5f7a2508bf69ef06d32cfd3f05384399890b886"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.8.10/horus-v0.8.10-linux-x86_64.tar.gz"
      sha256 "a06b76ec387f4c010ca30f7b2b8e0364ab624a8537b1d41b68ba102b58dd85ae"
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
