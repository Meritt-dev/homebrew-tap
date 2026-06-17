class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.14"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.14/horus-v0.1.14-darwin-arm64.tar.gz"
      sha256 "efc622f2b3c2bbeb7a81309eed4b09450a0498770ffd5a4a7d79a24ec95ed7b8"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.14/horus-v0.1.14-darwin-x86_64.tar.gz"
      sha256 "efc622f2b3c2bbeb7a81309eed4b09450a0498770ffd5a4a7d79a24ec95ed7b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.14/horus-v0.1.14-linux-arm64.tar.gz"
      sha256 "efc622f2b3c2bbeb7a81309eed4b09450a0498770ffd5a4a7d79a24ec95ed7b8"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.14/horus-v0.1.14-linux-x86_64.tar.gz"
      sha256 "efc622f2b3c2bbeb7a81309eed4b09450a0498770ffd5a4a7d79a24ec95ed7b8"
    end
  end

  def install
    bin.install "bin/horus"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/horus --version")
    assert_match "Usage: horus", shell_output("#{bin}/horus --help")
  end
end
