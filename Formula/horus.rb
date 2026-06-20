class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.2.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.1/horus-v0.2.1-darwin-arm64.tar.gz"
      sha256 "023b3cf19b5913ac6008f851ad53cab73a74c4bdba8e2e3bad00ae485d41f553"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.1/horus-v0.2.1-darwin-x86_64.tar.gz"
      sha256 "023b3cf19b5913ac6008f851ad53cab73a74c4bdba8e2e3bad00ae485d41f553"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.1/horus-v0.2.1-linux-arm64.tar.gz"
      sha256 "023b3cf19b5913ac6008f851ad53cab73a74c4bdba8e2e3bad00ae485d41f553"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.2.1/horus-v0.2.1-linux-x86_64.tar.gz"
      sha256 "023b3cf19b5913ac6008f851ad53cab73a74c4bdba8e2e3bad00ae485d41f553"
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
