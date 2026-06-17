class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.18"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.18/horus-v0.1.18-darwin-arm64.tar.gz"
      sha256 "f0cbaaab5c6b5429a98d7dda1aad594293758cfad6660ea8623532c16bdedcc5"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.18/horus-v0.1.18-darwin-x86_64.tar.gz"
      sha256 "f0cbaaab5c6b5429a98d7dda1aad594293758cfad6660ea8623532c16bdedcc5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.18/horus-v0.1.18-linux-arm64.tar.gz"
      sha256 "f0cbaaab5c6b5429a98d7dda1aad594293758cfad6660ea8623532c16bdedcc5"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.18/horus-v0.1.18-linux-x86_64.tar.gz"
      sha256 "f0cbaaab5c6b5429a98d7dda1aad594293758cfad6660ea8623532c16bdedcc5"
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
