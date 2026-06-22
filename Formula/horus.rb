class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.4.1"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.4.1/horus-v0.4.1-darwin-arm64.tar.gz"
      sha256 "fd1c63bf7643cb13d2b426f93610fba57843d48e0ab34cfb03a8e935594bcb9f"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.4.1/horus-v0.4.1-darwin-x86_64.tar.gz"
      sha256 "fd1c63bf7643cb13d2b426f93610fba57843d48e0ab34cfb03a8e935594bcb9f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.4.1/horus-v0.4.1-linux-arm64.tar.gz"
      sha256 "fd1c63bf7643cb13d2b426f93610fba57843d48e0ab34cfb03a8e935594bcb9f"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.4.1/horus-v0.4.1-linux-x86_64.tar.gz"
      sha256 "fd1c63bf7643cb13d2b426f93610fba57843d48e0ab34cfb03a8e935594bcb9f"
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
