class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.3.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.3.0/horus-v0.3.0-darwin-arm64.tar.gz"
      sha256 "66a6e4965a1e74ff17ba010df502c9d4b7529bcc3ba80a1b330cc4aec7993fbf"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.3.0/horus-v0.3.0-darwin-x86_64.tar.gz"
      sha256 "66a6e4965a1e74ff17ba010df502c9d4b7529bcc3ba80a1b330cc4aec7993fbf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.3.0/horus-v0.3.0-linux-arm64.tar.gz"
      sha256 "66a6e4965a1e74ff17ba010df502c9d4b7529bcc3ba80a1b330cc4aec7993fbf"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.3.0/horus-v0.3.0-linux-x86_64.tar.gz"
      sha256 "66a6e4965a1e74ff17ba010df502c9d4b7529bcc3ba80a1b330cc4aec7993fbf"
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
