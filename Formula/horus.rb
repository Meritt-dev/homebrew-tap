class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.4"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.4/horus-v0.1.4-darwin-arm64.tar.gz"
      sha256 "d49e62d3a3d76ac7983a206d1ab93d095dac2965279f3c0720bb2b389eb2ad3f"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.4/horus-v0.1.4-darwin-x86_64.tar.gz"
      sha256 "d49e62d3a3d76ac7983a206d1ab93d095dac2965279f3c0720bb2b389eb2ad3f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.4/horus-v0.1.4-linux-arm64.tar.gz"
      sha256 "d49e62d3a3d76ac7983a206d1ab93d095dac2965279f3c0720bb2b389eb2ad3f"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.4/horus-v0.1.4-linux-x86_64.tar.gz"
      sha256 "bde331af1546b04969b40d0620e0551d67d0865343090c1cc68a8eef9c359d9d"
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
