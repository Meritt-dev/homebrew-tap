class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.16"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.16/horus-v0.1.16-darwin-arm64.tar.gz"
      sha256 "d4c13034d46109b8bf7761273d92640691dc1fc753e82af545f0dca02632bee6"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.16/horus-v0.1.16-darwin-x86_64.tar.gz"
      sha256 "bad826e6eacfbb475e838b8fe7d087e7c1e397b9edf3cffc3223689e1c4f20d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.16/horus-v0.1.16-linux-arm64.tar.gz"
      sha256 "bad826e6eacfbb475e838b8fe7d087e7c1e397b9edf3cffc3223689e1c4f20d6"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.16/horus-v0.1.16-linux-x86_64.tar.gz"
      sha256 "bad826e6eacfbb475e838b8fe7d087e7c1e397b9edf3cffc3223689e1c4f20d6"
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
