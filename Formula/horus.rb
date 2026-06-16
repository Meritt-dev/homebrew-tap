class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.6"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.6/horus-v0.1.6-darwin-arm64.tar.gz"
      sha256 "22f3ecb1087e89697f003849c744fd20c94881e97380a03a951d1d5edb66eea5"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.6/horus-v0.1.6-darwin-x86_64.tar.gz"
      sha256 "22f3ecb1087e89697f003849c744fd20c94881e97380a03a951d1d5edb66eea5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.6/horus-v0.1.6-linux-arm64.tar.gz"
      sha256 "22f3ecb1087e89697f003849c744fd20c94881e97380a03a951d1d5edb66eea5"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.6/horus-v0.1.6-linux-x86_64.tar.gz"
      sha256 "22f3ecb1087e89697f003849c744fd20c94881e97380a03a951d1d5edb66eea5"
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
