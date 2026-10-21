class Horus < Formula
  desc "Local-first, source-aware production-incident investigation engine"
  homepage "https://horus.sh"
  version "0.24.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.1/horus-cli-aarch64-apple-darwin.tar.gz"
      sha256 "3131769f230867c4f30c241d6b383ccdb01d6eaea6c85f7107df5bfa903be0fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.1/horus-cli-x86_64-apple-darwin.tar.gz"
      sha256 "851b125c6f32d183e8d5b5b8b30dcf70f93553e49bbdf339b1b9e111e7a39da3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.1/horus-cli-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e268fbd21e8bafa0d3103387a8e3b0f6f1b468e14ad8a58462b0f64ac92dda69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Meritt-dev/horus-rust/releases/download/v0.24.1/horus-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "920f2fd8d98efe935adb4f99a33c2c32306d45c80f0162b5d4c4d5ebed6a55ee"
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
