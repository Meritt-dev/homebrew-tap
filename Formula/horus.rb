class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.8"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.8/horus-v0.1.8-darwin-arm64.tar.gz"
      sha256 "0029400a008fe2414352059c9c5c96c372a3615c71f336ec2b095aae2481bc1b"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.8/horus-v0.1.8-darwin-x86_64.tar.gz"
      sha256 "b0bf92722a16c115a28b295c93322f2e91d267e508e43009e467e4b6269bc47d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.8/horus-v0.1.8-linux-arm64.tar.gz"
      sha256 "b0bf92722a16c115a28b295c93322f2e91d267e508e43009e467e4b6269bc47d"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.8/horus-v0.1.8-linux-x86_64.tar.gz"
      sha256 "b0bf92722a16c115a28b295c93322f2e91d267e508e43009e467e4b6269bc47d"
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
