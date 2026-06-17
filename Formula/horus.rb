class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.15"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.15/horus-v0.1.15-darwin-arm64.tar.gz"
      sha256 "569f0c85db717d4d6059efabe5a5f21e768a9f99af1da6fce7b463a11ce3bae6"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.15/horus-v0.1.15-darwin-x86_64.tar.gz"
      sha256 "569f0c85db717d4d6059efabe5a5f21e768a9f99af1da6fce7b463a11ce3bae6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.15/horus-v0.1.15-linux-arm64.tar.gz"
      sha256 "569f0c85db717d4d6059efabe5a5f21e768a9f99af1da6fce7b463a11ce3bae6"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.15/horus-v0.1.15-linux-x86_64.tar.gz"
      sha256 "569f0c85db717d4d6059efabe5a5f21e768a9f99af1da6fce7b463a11ce3bae6"
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
