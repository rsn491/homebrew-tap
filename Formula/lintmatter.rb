class Lintmatter < Formula
  desc "A linter for agentic context"
  homepage "https://github.com/rsn491/lintmatter"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.2.0/lintmatter-aarch64-apple-darwin.tar.xz"
      sha256 "e6f178210fd4899f5875049d53680cedee15708888abe8bb12e870f141df486e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.2.0/lintmatter-x86_64-apple-darwin.tar.xz"
      sha256 "9a00338ac5c4af48008db6de5f612b721bb3cd56f350fc032049fa1062cd767e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.2.0/lintmatter-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cb28ce80434c875b677eac576e60f1db3b0e349af1c3e6318be78f598965a3b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.2.0/lintmatter-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f3d972976eb1ff3498bee17722953d17c8cd54aa5a6ccb3278bd80ed98b8d8d7"
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
