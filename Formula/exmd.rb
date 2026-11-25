class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.2/exmd-darwin-arm64.tar.gz"
      sha256 "b527bae63df43785bd4f1d6e47b7284ffe394f3852be45a5edfbfd54b92159bd"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.2/exmd-darwin-amd64.tar.gz"
      sha256 "24f0bce44dd615d6f831a888a40616844e918c77e6322cabb35906031a54cbc5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.2/exmd-linux-arm64.tar.gz"
      sha256 "43fc080ba20187af40d9ca2301f128b9490c7fc8f18544bd951ecff5ea46fc54"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.6.2/exmd-linux-amd64.tar.gz"
      sha256 "a27e31791a9ce8ea4407a5ede9f9d76e7ea335bc22771b18c405247113c65494"
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
