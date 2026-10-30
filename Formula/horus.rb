class Horus < Formula
  desc "Local-first, source-aware production-incident investigation engine"
  homepage "https://horus.sh"
  version "0.24.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.4/horus-cli-aarch64-apple-darwin.tar.gz"
      sha256 "b4e48d0553416c6856a1f355db23bc2894971976a810034084993e81e2f987e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.4/horus-cli-x86_64-apple-darwin.tar.gz"
      sha256 "79f1da471bf4be200f61b426540ee61d6753bd3d0a297feac71dcb81b784edf2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.4/horus-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "35d0c7e78f6ac62bbdc3f8d329e996e449e0e9f7e79b714116adb1def9802458"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.4/horus-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e00959d1b470c16bde6d606864f9ba2fae714025829f06ef1ea5de7dbb72e707"
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
