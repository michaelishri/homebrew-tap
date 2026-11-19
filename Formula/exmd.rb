class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.2.0/exmd-darwin-arm64.tar.gz"
      sha256 "b8678b2f2021175fb101865339530ae66e89a1740dde10b357a325750fa98e6e"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.2.0/exmd-darwin-amd64.tar.gz"
      sha256 "a9917c135352b6a696d7ec2a20d2ef397b2d518c194ddbdd01c65df4f569c6d0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.2.0/exmd-linux-arm64.tar.gz"
      sha256 "b0202ddfa7e9c9c4da43298fdbf87548a30eab88f2b2ebd89623e6d789d8d942"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.2.0/exmd-linux-amd64.tar.gz"
      sha256 "5d1cfa5647ced8f6fd81ff4e29bed9c2281feec7be4c1ea4faaf6f8ffa08bcc7"
    end
  end

  version "0.2.0"

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
