class Exmd < Formula
  desc "Run executable Markdown runbooks in your terminal"
  homepage "https://github.com/michaelishri/exmd"

  on_macos do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.5.0/exmd-darwin-arm64.tar.gz"
      sha256 "2dcc6a85995f67e3f572381b0441c69e4495b93c43446a7603b46d0c87d632d6"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.5.0/exmd-darwin-amd64.tar.gz"
      sha256 "d209a2bb1ee21b8d17f0b251129f4c2b108f804c4426da049dd5bf34b638013f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaelishri/exmd/releases/download/v0.5.0/exmd-linux-arm64.tar.gz"
      sha256 "043ece13428897be3982469cdec884b904a31be03f717678c494048467421250"
    end
    on_intel do
      url "https://github.com/michaelishri/exmd/releases/download/v0.5.0/exmd-linux-amd64.tar.gz"
      sha256 "061bead951d5c3a3081ee18b9138961b9d2db107a220d01221542a131ec18f2a"
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
