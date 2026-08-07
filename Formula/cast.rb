class Cast < Formula
  desc "Stream local video and a macOS desktop to Google Cast devices"
  homepage "https://github.com/michaelishri/cast-rs"
  url "https://github.com/michaelishri/cast-rs/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "595b43c77c79577e8f6c311d99303182ab1b2282eae0612934a05f275aa41b34"
  license "MIT"
  head "https://github.com/michaelishri/cast-rs.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build
  depends_on xcode: ["15.0", :build]
  depends_on macos: :ventura

  def install
    system "cargo", "install", *std_cargo_args
    doc.install "LICENSE", "README.md", "docs/USER_GUIDE.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cast --version")

    (testpath/"invalid.mp4").write "not a media file"
    output = shell_output("#{bin}/cast video --host 127.0.0.1 #{testpath}/invalid.mp4 2>&1", 1)
    assert_match "could not identify", output
  end
end
