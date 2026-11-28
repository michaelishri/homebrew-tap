class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.7.0/exmd-darwin-arm64.tar.gz"
      sha256 "33a40cb50dbcb3a1ae5c245b948f1a20f98fbeb31b7552c756a15d0d37f828f8"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.7.0/exmd-darwin-amd64.tar.gz"
      sha256 "0b88aa4e8cd95025587aaf41dbd30295a306c455bdd49d99b81ad0cc227dbf90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.7.0/exmd-linux-arm64.tar.gz"
      sha256 "4d546543d798b9d8a914cb2c029cf74710c1ca3cf52e70ecd027bb506cdcde5f"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.7.0/exmd-linux-amd64.tar.gz"
      sha256 "03a655a0782c915ff43470e59fbbc7a97b0a5522ae58d738d221e43780aeb9f4"
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
