class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.10"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.10/horus-v0.1.10-darwin-arm64.tar.gz"
      sha256 "ce06c0ef76a9d0d65216b69e7662f39aa7887b4ece46de66c7635122b68a86de"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.10/horus-v0.1.10-darwin-x86_64.tar.gz"
      sha256 "ce06c0ef76a9d0d65216b69e7662f39aa7887b4ece46de66c7635122b68a86de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.10/horus-v0.1.10-linux-arm64.tar.gz"
      sha256 "9cb1ee3e3b65f37efd41df35ec3c7289fdbc1a110c863cbe3c7486b465c8ffc1"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.10/horus-v0.1.10-linux-x86_64.tar.gz"
      sha256 "9cb1ee3e3b65f37efd41df35ec3c7289fdbc1a110c863cbe3c7486b465c8ffc1"
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
