class Horus < Formula
  desc "Local-first, source-aware production-incident investigation engine"
  homepage "https://horus.sh"
  version "0.24.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.0/horus-cli-aarch64-apple-darwin.tar.gz"
      sha256 "e559302348485aec6fa6b721d13975575daf1d5be541244e8011585ed97832e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.0/horus-cli-x86_64-apple-darwin.tar.gz"
      sha256 "f1053d10ae3d1e02d08834cd9671b32240554b1d8a643f0a1fcd8ea139714209"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.0/horus-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b2298741c83a581a6883616e7f43483c6d6e78ae1b722f9c3febb28348895e34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.0/horus-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6f9e6b2818998930c9577c24f134144861c5461f756bbc28219a5c683b3e3ad5"
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
