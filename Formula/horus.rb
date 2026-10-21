class Horus < Formula
  desc "Local-first, source-aware production-incident investigation engine"
  homepage "https://horus.sh"
  version "0.24.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.2/horus-cli-aarch64-apple-darwin.tar.gz"
      sha256 "f1b1892a1f4b8c50c5f0eeb635e21671526aa6b405f06d512766a10a40ae734c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.2/horus-cli-x86_64-apple-darwin.tar.gz"
      sha256 "71ef4aa494e8b2ab3a5c6bd9876c3b20321b09080b8c34f42bd4d76cba2d3b39"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.2/horus-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4fd4a7136d9812629d2cc4975d8819d2bfe150186ee66647618c72dab601fc8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.2/horus-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6601ca34455fc49c430e595d7f5526f3c6516cbfcde2c3aa5c987d774fee5211"
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
