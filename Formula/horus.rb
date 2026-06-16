class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.11"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.11/horus-v0.1.11-darwin-arm64.tar.gz"
      sha256 "96a7b3ff5fb21acff3350f8e0f4a58c9982b3cea28403f6658b18f4d2764f923"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.11/horus-v0.1.11-darwin-x86_64.tar.gz"
      sha256 "96a7b3ff5fb21acff3350f8e0f4a58c9982b3cea28403f6658b18f4d2764f923"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.11/horus-v0.1.11-linux-arm64.tar.gz"
      sha256 "96a7b3ff5fb21acff3350f8e0f4a58c9982b3cea28403f6658b18f4d2764f923"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.11/horus-v0.1.11-linux-x86_64.tar.gz"
      sha256 "96a7b3ff5fb21acff3350f8e0f4a58c9982b3cea28403f6658b18f4d2764f923"
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
