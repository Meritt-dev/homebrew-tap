class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.5"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.5/horus-v0.1.5-darwin-arm64.tar.gz"
      sha256 "a8769a321f1d82f4a379fcbff18f227cd0035b5a0d7feb84ca4ce067ebf7c8bf"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.5/horus-v0.1.5-darwin-x86_64.tar.gz"
      sha256 "a8769a321f1d82f4a379fcbff18f227cd0035b5a0d7feb84ca4ce067ebf7c8bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.5/horus-v0.1.5-linux-arm64.tar.gz"
      sha256 "a8769a321f1d82f4a379fcbff18f227cd0035b5a0d7feb84ca4ce067ebf7c8bf"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.5/horus-v0.1.5-linux-x86_64.tar.gz"
      sha256 "a8769a321f1d82f4a379fcbff18f227cd0035b5a0d7feb84ca4ce067ebf7c8bf"
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
