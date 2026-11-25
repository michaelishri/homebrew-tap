class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.1/exmd-darwin-arm64.tar.gz"
      sha256 "646c44a6ffa48033d91981ac35ea517d4635c850f22145b3c08a2366845ee0d0"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.1/exmd-darwin-amd64.tar.gz"
      sha256 "8090c7378b91e8967d907d6075203c3ceed87997aa24c1c356d7b59b69e95c73"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.1/exmd-linux-arm64.tar.gz"
      sha256 "6200fe2587a08ebcedb942a44380c35ba9cb843303ff3050290d880a1689ad78"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.1/exmd-linux-amd64.tar.gz"
      sha256 "d3882d1e3a10686379eb551a3f5c33f767c0deda645aa4e4cbb63edbec5e432f"
    end
  end

  def install
    bin.install "exmd"
  end

  test do
    runbook = testpath/"runbook.md"
    runbook.write <<~MARKDOWN
      ---
      type: runbook
      title: Homebrew test
      ---

      # Example runbook
    MARKDOWN

    assert_match "no issues", shell_output("#{bin}/exmd check #{runbook}")
  end
end
