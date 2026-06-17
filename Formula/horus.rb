class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.1.12"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.12/horus-v0.1.12-darwin-arm64.tar.gz"
      sha256 "0457010a030598b55a221a77f1d56aea023c1bff8634b5685c5b5aca7c8e8499"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.12/horus-v0.1.12-darwin-x86_64.tar.gz"
      sha256 "0457010a030598b55a221a77f1d56aea023c1bff8634b5685c5b5aca7c8e8499"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.12/horus-v0.1.12-linux-arm64.tar.gz"
      sha256 "0457010a030598b55a221a77f1d56aea023c1bff8634b5685c5b5aca7c8e8499"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.1.12/horus-v0.1.12-linux-x86_64.tar.gz"
      sha256 "03c56468e83ec9f0b8def740bff3ee853fa15eb747e5744aef0b63d626e86257"
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
