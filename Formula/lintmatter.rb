class Lintmatter < Formula
  desc "A linter for agentic context"
  homepage "https://github.com/rsn491/lintmatter"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.1.1/lintmatter-aarch64-apple-darwin.tar.xz"
      sha256 "2ab9cefb77e00d704ca5d8a7c8a5a1f8468d4beaa0188f2571aa6263e9066278"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.1.1/lintmatter-x86_64-apple-darwin.tar.xz"
      sha256 "1bfbfb920ddf4d64f742a07b5402d0e10bd205039a987a718d5f68776ef6f6b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.1.1/lintmatter-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f81b777ad3ebbd5fc12ff286cb826ad0b3c571f35d8fe8fb6774e93da6678fb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.1.1/lintmatter-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "341b7a1ddc93a596bbf547ea1d5e4915b845c864e07fb0b33eed253ee70b3e7d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "lintmatter"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lintmatter"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lintmatter"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lintmatter"
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
