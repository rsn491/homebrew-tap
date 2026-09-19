class Lintmatter < Formula
  desc "Linter for agent instruction files"
  homepage "https://github.com/rsn491/lintmatter"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.1.0/lintmatter-aarch64-apple-darwin.tar.xz"
      sha256 "8b7d56ca52c7d45e2f6157f8523405a8ef469f4f6a6d6d92a5212f1f46192194"
    else
      url "https://github.com/rsn491/lintmatter/releases/download/v0.1.0/lintmatter-x86_64-apple-darwin.tar.xz"
      sha256 "fa8f357c8623ce49b12bfabac99626ce6b3ec7153dccd0ece65c5b67a8187d81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rsn491/lintmatter/releases/download/v0.1.0/lintmatter-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3bfc7c0cf007f0efb9744bb44f70c0235cc2bf736d8d1e8575318833eb247d0e"
    else
      url "https://github.com/rsn491/lintmatter/releases/download/v0.1.0/lintmatter-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c14b961efec782837e7a58588546af4accb0a9caaffe0557bfa950c220daca34"
    end
  end

  def install
    bin.install "lintmatter"
  end

  test do
    (testpath/"AGENTS.md").write <<~MARKDOWN
      # Agent instructions

      Keep changes focused and run the tests before committing.
    MARKDOWN

    output = shell_output("#{bin}/lintmatter --no-config --color never #{testpath}")
    assert_match "Score: 100/100 · Healthy", output
    assert_match "1 file checked, 0 files with errors, 0 files with warnings", output
    assert_match version.to_s, shell_output("#{bin}/lintmatter --version")
  end
end
