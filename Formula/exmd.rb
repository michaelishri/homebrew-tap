class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.0/exmd-darwin-arm64.tar.gz"
      sha256 "5460ff8f1202c0c48a40271a576ea04b4afd01297bad5c0e0ad246f214eb7ba9"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.0/exmd-darwin-amd64.tar.gz"
      sha256 "ae56bacd7ad43268c46566e6bd8af88ce9af6c685435a917f9ba6cdfb9569b54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.0/exmd-linux-arm64.tar.gz"
      sha256 "fb47c04b6be50878c39da25ba1fb8e8f5e4084cb3e8a8cfb1a3472118315d4f0"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.0/exmd-linux-amd64.tar.gz"
      sha256 "e7bed3ddfdac7c5ddbbdf71b56bca295ba5930cb11431164269150bb4078f107"
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
