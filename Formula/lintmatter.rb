class Lintmatter < Formula
  desc "A linter for agentic context"
  homepage "https://github.com/rsn491/lintmatter"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.2.1/lintmatter-aarch64-apple-darwin.tar.xz"
      sha256 "df3db200e3df51f6d333f0a5249876e32f8e35c74fdc612c60693a26cc6d6daa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.2.1/lintmatter-x86_64-apple-darwin.tar.xz"
      sha256 "3bbdf9cd264daa8d01fc6fe3a0862c04193b74ad63152cddac392713c771b31a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.2.1/lintmatter-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9cdbfc7faa1a6d81f43330205c338f8579d85d4f9884c928f2a93bdd37da3d44"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.2.1/lintmatter-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2d4f80d788809107e3e356d5144ec6b2799d9ebcbdbcfc47a7f78766bda81293"
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
