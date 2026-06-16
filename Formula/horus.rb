class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.3"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.3/horus-v0.1.3-darwin-arm64.tar.gz"
      sha256 "ff9d2c49fdf5b1162ec9bdb397d07d8409875bb3ac80b259efffc1bcb224a6dd"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.3/horus-v0.1.3-darwin-x86_64.tar.gz"
      sha256 "ff9d2c49fdf5b1162ec9bdb397d07d8409875bb3ac80b259efffc1bcb224a6dd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.3/horus-v0.1.3-linux-arm64.tar.gz"
      sha256 "ff9d2c49fdf5b1162ec9bdb397d07d8409875bb3ac80b259efffc1bcb224a6dd"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.3/horus-v0.1.3-linux-x86_64.tar.gz"
      sha256 "58e6633e9c79222b88a686715ac33db8a8c9df5c47b287206a3df2650b90eb52"
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
