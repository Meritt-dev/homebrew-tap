class Horus < Formula
  desc "Local-first, source-aware production-incident investigation engine"
  homepage "https://horus.sh"
  version "0.24.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.3/horus-cli-aarch64-apple-darwin.tar.gz"
      sha256 "f9a1647b4c89d1b91f39572cea92c13680627880f780aceb7954df7d06b4e131"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.3/horus-cli-x86_64-apple-darwin.tar.gz"
      sha256 "b797ba3619346dbeaa40e6877075fe4a18fa00ff736d38d44b7f14bcd08c02e9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.3/horus-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f7b8e70835a9e8faa533bffbb931cc0d3d2c6b348726b53421199a11714f1b22"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.3/horus-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3a38976b0d25b331b49faee3ec94efc9598c65d39572f8bc2abdd84de607d118"
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
