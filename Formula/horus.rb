class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.6.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.6.0/horus-v0.6.0-darwin-arm64.tar.gz"
      sha256 "3b3b6620b94e2b7348e3bad2046db5936bda328d57b949bf21925219951e6a47"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.6.0/horus-v0.6.0-darwin-x86_64.tar.gz"
      sha256 "3b3b6620b94e2b7348e3bad2046db5936bda328d57b949bf21925219951e6a47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.6.0/horus-v0.6.0-linux-arm64.tar.gz"
      sha256 "3b3b6620b94e2b7348e3bad2046db5936bda328d57b949bf21925219951e6a47"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.6.0/horus-v0.6.0-linux-x86_64.tar.gz"
      sha256 "3b3b6620b94e2b7348e3bad2046db5936bda328d57b949bf21925219951e6a47"
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
