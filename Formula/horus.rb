class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.2.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.0/horus-v0.2.0-darwin-arm64.tar.gz"
      sha256 "771ed359eda6ea30c92aeeecdc85c898e5918515bbb9d3a10c9bb47e240e6343"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.0/horus-v0.2.0-darwin-x86_64.tar.gz"
      sha256 "c5353735c1d8b56c51b4fbb6e6ee53a679363fcea2eb3b7db11cfcdf9e39e1d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.0/horus-v0.2.0-linux-arm64.tar.gz"
      sha256 "c5353735c1d8b56c51b4fbb6e6ee53a679363fcea2eb3b7db11cfcdf9e39e1d7"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.0/horus-v0.2.0-linux-x86_64.tar.gz"
      sha256 "c5353735c1d8b56c51b4fbb6e6ee53a679363fcea2eb3b7db11cfcdf9e39e1d7"
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
