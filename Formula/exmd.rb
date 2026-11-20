class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.2.1/exmd-darwin-arm64.tar.gz"
      sha256 "4ca29186f8f92435163af66e6cfeea9f3709ba2ca2aac16ebf9fcde3bd751de6"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.2.1/exmd-darwin-amd64.tar.gz"
      sha256 "d6e5862eef2a9f202888d8662cb359a14925069d36b38291375b6f66836afd50"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.2.1/exmd-linux-arm64.tar.gz"
      sha256 "f1c453e2c82fa7d4cedcb7d83a33b47d4f5a08672995c0dc230804ba515535a8"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.2.1/exmd-linux-amd64.tar.gz"
      sha256 "ffc9426030236c907c7ed1fab33cf7ea4fd56224fe4fdc1fe2d61c7a277c6e11"
    end
  end

  version "0.2.1"

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
