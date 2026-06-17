class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.17"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.17/horus-v0.1.17-darwin-arm64.tar.gz"
      sha256 "e53a4002231f1a022863160fc45b531f43c55196eef3f05e97f6b37c90012da9"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.17/horus-v0.1.17-darwin-x86_64.tar.gz"
      sha256 "3389e5b0e88e32b7fffb2bb598f27f99a882d3026951259e1ece0910d99c70f9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.17/horus-v0.1.17-linux-arm64.tar.gz"
      sha256 "3389e5b0e88e32b7fffb2bb598f27f99a882d3026951259e1ece0910d99c70f9"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.17/horus-v0.1.17-linux-x86_64.tar.gz"
      sha256 "3389e5b0e88e32b7fffb2bb598f27f99a882d3026951259e1ece0910d99c70f9"
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
