class Horus < Formula
  desc "Local-first, source-aware production-incident investigation engine"
  homepage "https://horus.sh"
  version "0.24.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus/releases/download/v0.24.6/horus-cli-aarch64-apple-darwin.tar.gz"
      sha256 "021e8cc571e1fd3b1d527c92b8972889ed4127e528438429493f862948855150"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus/releases/download/v0.24.6/horus-cli-x86_64-apple-darwin.tar.gz"
      sha256 "5b70d8017f67868068b13e555322b33ae280811f80a15c6e79098db096ff287c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus/releases/download/v0.24.6/horus-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b8aad7cccded3cdbe8fa66eb936c0ae072bdb6050b533981a371a98f88fbb3da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus/releases/download/v0.24.6/horus-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f45465928945cf5f37d43c82329cf78866b7f662f0cdee49d3fa66771ab88dbf"
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
