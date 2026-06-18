class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.19"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.19/horus-v0.1.19-darwin-arm64.tar.gz"
      sha256 "ca9df85c97b1bf7a3b3171cfb3c01cc5858e8b59234fae54fba71d27b5e52145"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.19/horus-v0.1.19-darwin-x86_64.tar.gz"
      sha256 "ca9df85c97b1bf7a3b3171cfb3c01cc5858e8b59234fae54fba71d27b5e52145"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.19/horus-v0.1.19-linux-arm64.tar.gz"
      sha256 "ca9df85c97b1bf7a3b3171cfb3c01cc5858e8b59234fae54fba71d27b5e52145"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.19/horus-v0.1.19-linux-x86_64.tar.gz"
      sha256 "ca9df85c97b1bf7a3b3171cfb3c01cc5858e8b59234fae54fba71d27b5e52145"
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
