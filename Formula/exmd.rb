class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.1.0/exmd-darwin-arm64.tar.gz"
      sha256 "5fa03b7b36a5770e5c121462a89ad62da907ba389dc09e802b90ccc5d59c9326"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.1.0/exmd-darwin-amd64.tar.gz"
      sha256 "77b7dc34ab09024160ec73b2cdeca3c7cba97098a1c63b182ec0b73f2591ab7c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.1.0/exmd-linux-arm64.tar.gz"
      sha256 "2a77a3bda318e0a28cd69547193d655208d2039b0128f881438b86b6e5d94cea"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.1.0/exmd-linux-amd64.tar.gz"
      sha256 "028c5c2a155ed0ddb8f5f99f8e1520bb1e987d2f9586cda9fc578e979bfebe00"
    end
  end

  version "0.1.0"

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
