class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.4.0/exmd-darwin-arm64.tar.gz"
      sha256 "34910dfa6555fbc5cf29f1f3b7858d535055105cac8ac2db54bea26775266262"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.4.0/exmd-darwin-amd64.tar.gz"
      sha256 "79fe1658448826c56a3cea7c63071c964d5dde558148c72f80ab0e9042360625"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.4.0/exmd-linux-arm64.tar.gz"
      sha256 "1c704f92aaf4537ea204ab9304ea41d85a22a81ec10994a0b93fd3dfc626eac9"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.4.0/exmd-linux-amd64.tar.gz"
      sha256 "38a5506965cc075f7c99444eb6b86d51b61b0876dfbf6c771436804b00408d4e"
    end
  end

  version "0.4.0"

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
