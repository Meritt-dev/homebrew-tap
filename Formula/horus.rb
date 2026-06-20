class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.2.2"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.2/horus-v0.2.2-darwin-arm64.tar.gz"
      sha256 "2953ccfa072e03a49bba259e07e10ec86a1333ca77d22bc43fa054306440f6ce"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.2/horus-v0.2.2-darwin-x86_64.tar.gz"
      sha256 "2953ccfa072e03a49bba259e07e10ec86a1333ca77d22bc43fa054306440f6ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.2/horus-v0.2.2-linux-arm64.tar.gz"
      sha256 "2953ccfa072e03a49bba259e07e10ec86a1333ca77d22bc43fa054306440f6ce"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.2/horus-v0.2.2-linux-x86_64.tar.gz"
      sha256 "21f466b4380d769f6082c4416a2329d9326f9d14f898c53b78be50d795575ee0"
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
