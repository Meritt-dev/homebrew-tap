class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.21.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.1/horus-v0.21.1-darwin-arm64.tar.gz"
      sha256 "e376f0664bd15f12f55fe86efb06533af6b2a735db68446ac436b310c5b7edda"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.1/horus-v0.21.1-darwin-x86_64.tar.gz"
      sha256 "5bd95cbef67f1a913f43c641aa1c7e2b9090b9aa8370dd9cd1c43b7f77988b1e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.1/horus-v0.21.1-linux-arm64.tar.gz"
      sha256 "3a4531fd382f6583dfd10ec1073509044045effede857295f8539a9c8035eb75"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.21.1/horus-v0.21.1-linux-x86_64.tar.gz"
      sha256 "bf89f964852cd42e378cac6ca10aed4a544e633866176030a81c5edf8e6ae3c8"
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
