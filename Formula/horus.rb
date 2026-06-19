class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.20"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.20/horus-v0.1.20-darwin-arm64.tar.gz"
      sha256 "3f8e74d5dd0c0abceb123ee91ccbb51d5c02474dc22b809fd191ae53dfe6f289"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.20/horus-v0.1.20-darwin-x86_64.tar.gz"
      sha256 "3f8e74d5dd0c0abceb123ee91ccbb51d5c02474dc22b809fd191ae53dfe6f289"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.20/horus-v0.1.20-linux-arm64.tar.gz"
      sha256 "3f8e74d5dd0c0abceb123ee91ccbb51d5c02474dc22b809fd191ae53dfe6f289"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.20/horus-v0.1.20-linux-x86_64.tar.gz"
      sha256 "3f8e74d5dd0c0abceb123ee91ccbb51d5c02474dc22b809fd191ae53dfe6f289"
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
