class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.7"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.7/horus-v0.1.7-darwin-arm64.tar.gz"
      sha256 "34d6319ad9e2ac899400f0b586ce4102ece6cfc3059dc729e2d0b06208ef09d3"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.7/horus-v0.1.7-darwin-x86_64.tar.gz"
      sha256 "34d6319ad9e2ac899400f0b586ce4102ece6cfc3059dc729e2d0b06208ef09d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.7/horus-v0.1.7-linux-arm64.tar.gz"
      sha256 "34d6319ad9e2ac899400f0b586ce4102ece6cfc3059dc729e2d0b06208ef09d3"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.7/horus-v0.1.7-linux-x86_64.tar.gz"
      sha256 "34d6319ad9e2ac899400f0b586ce4102ece6cfc3059dc729e2d0b06208ef09d3"
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
