class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.5.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.5.0/horus-v0.5.0-darwin-arm64.tar.gz"
      sha256 "6120a275cb0d37b8da72a9e1e3b9bb0f32da023f20411e45ecd0f7252a9924c2"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.5.0/horus-v0.5.0-darwin-x86_64.tar.gz"
      sha256 "6120a275cb0d37b8da72a9e1e3b9bb0f32da023f20411e45ecd0f7252a9924c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.5.0/horus-v0.5.0-linux-arm64.tar.gz"
      sha256 "6120a275cb0d37b8da72a9e1e3b9bb0f32da023f20411e45ecd0f7252a9924c2"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.5.0/horus-v0.5.0-linux-x86_64.tar.gz"
      sha256 "6120a275cb0d37b8da72a9e1e3b9bb0f32da023f20411e45ecd0f7252a9924c2"
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
