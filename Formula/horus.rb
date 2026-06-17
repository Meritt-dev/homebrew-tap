class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.13"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.13/horus-v0.1.13-darwin-arm64.tar.gz"
      sha256 "c28f454a0b7abf493bf6fc8723cc83985502251315c4da8a1f816fba5b3b2926"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.13/horus-v0.1.13-darwin-x86_64.tar.gz"
      sha256 "c28f454a0b7abf493bf6fc8723cc83985502251315c4da8a1f816fba5b3b2926"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.13/horus-v0.1.13-linux-arm64.tar.gz"
      sha256 "c28f454a0b7abf493bf6fc8723cc83985502251315c4da8a1f816fba5b3b2926"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.13/horus-v0.1.13-linux-x86_64.tar.gz"
      sha256 "c28f454a0b7abf493bf6fc8723cc83985502251315c4da8a1f816fba5b3b2926"
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
