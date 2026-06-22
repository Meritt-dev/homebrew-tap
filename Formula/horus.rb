class Horus < Formula
  desc "Local-first, source-aware incident investigation engine"
  homepage "https://horus.sh"
  version "0.4.0"
  license "MIT"

  depends_on "node"

  on_macos do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.4.0/horus-v0.4.0-darwin-arm64.tar.gz"
      sha256 "c7a1db954f2ce8184915d2e103abfd083a9f3df6f9d0ca742765dbcdf2e20577"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.4.0/horus-v0.4.0-darwin-x86_64.tar.gz"
      sha256 "c7a1db954f2ce8184915d2e103abfd083a9f3df6f9d0ca742765dbcdf2e20577"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meritt-dev/horus/releases/download/v0.4.0/horus-v0.4.0-linux-arm64.tar.gz"
      sha256 "c7a1db954f2ce8184915d2e103abfd083a9f3df6f9d0ca742765dbcdf2e20577"
    end
    on_intel do
      url "https://github.com/meritt-dev/horus/releases/download/v0.4.0/horus-v0.4.0-linux-x86_64.tar.gz"
      sha256 "c7a1db954f2ce8184915d2e103abfd083a9f3df6f9d0ca742765dbcdf2e20577"
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
