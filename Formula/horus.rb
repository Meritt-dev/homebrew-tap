class Horus < Formula
  desc "Local-first, source-aware production-incident investigation engine"
  homepage "https://horus.sh"
  version "0.24.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus/releases/download/v0.24.5/horus-cli-aarch64-apple-darwin.tar.gz"
      sha256 "819b9bbc57f77b4c50ca7a214a5d2eb3d1073e15dc4e90e4b2a8a9881296e2f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus/releases/download/v0.24.5/horus-cli-x86_64-apple-darwin.tar.gz"
      sha256 "8641d802eb596676b75b05012d3f306a7f8dd8b11e3bdeb3298f49ee66118ed3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus/releases/download/v0.24.5/horus-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "94bb5eb815570f7ac15bc7b758d48633694c49f00db3b1fa2aed4c0d7a23b10f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus/releases/download/v0.24.5/horus-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "db6dcb40334f3b5f9591923ebea4c0865bcf146509010d4cb0807918039d46c0"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "horus"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "horus"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "horus"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "horus"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
