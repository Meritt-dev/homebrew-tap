class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.9"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.9/horus-v0.1.9-darwin-arm64.tar.gz"
      sha256 "9db98bf876dc446cf2f150c36e99cb63f073daacf779ffcf4b5f5e61a28f5d22"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.9/horus-v0.1.9-darwin-x86_64.tar.gz"
      sha256 "9db98bf876dc446cf2f150c36e99cb63f073daacf779ffcf4b5f5e61a28f5d22"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.9/horus-v0.1.9-linux-arm64.tar.gz"
      sha256 "35239ba53464b1d7a6fae49be9dd6c1c4d0811ecd20e60bc20662b66e1b5fd4e"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.9/horus-v0.1.9-linux-x86_64.tar.gz"
      sha256 "35239ba53464b1d7a6fae49be9dd6c1c4d0811ecd20e60bc20662b66e1b5fd4e"
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
