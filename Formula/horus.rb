class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.2.3"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.3/horus-v0.2.3-darwin-arm64.tar.gz"
      sha256 "4e14129de6a7b2e7db15acffdff9a4aabbfaec14a50ea9a9bf8e520627dbb76b"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.3/horus-v0.2.3-darwin-x86_64.tar.gz"
      sha256 "4e14129de6a7b2e7db15acffdff9a4aabbfaec14a50ea9a9bf8e520627dbb76b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.3/horus-v0.2.3-linux-arm64.tar.gz"
      sha256 "4e14129de6a7b2e7db15acffdff9a4aabbfaec14a50ea9a9bf8e520627dbb76b"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.3/horus-v0.2.3-linux-x86_64.tar.gz"
      sha256 "4e14129de6a7b2e7db15acffdff9a4aabbfaec14a50ea9a9bf8e520627dbb76b"
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
