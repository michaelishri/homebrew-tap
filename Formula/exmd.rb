class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.3.0/exmd-darwin-arm64.tar.gz"
      sha256 "ebca31b83668a3a8b6bd1ce8a33c3ceb5296daa2e3ee3959ef6b9b693e7f9c67"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.3.0/exmd-darwin-amd64.tar.gz"
      sha256 "09fc7aa7c22b2d16286d0059ab39fbe91abb57ad3a03d3a68b8d0ea4ca9004e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.3.0/exmd-linux-arm64.tar.gz"
      sha256 "507b53585f3affb94a878d7aac7b744126f40a63c858d75eba9ae4c124c117c8"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.3.0/exmd-linux-amd64.tar.gz"
      sha256 "8f60a8c231ee714f8561c4d4c714ccfaca939009d60c6b8fc6b97612776b3f9c"
    end
  end

  version "0.3.0"

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
