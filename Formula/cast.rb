require "macho"

class Cast < Formula
  desc "Stream local video and a macOS desktop to Google Cast devices"
  homepage "https://github.com/michaelishri/cast-rs"
  url "https://github.com/michaelishri/cast-rs/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "351dda2ba74116d7ab365097a8a0ee026bc17c626ce51eb2014cf2d4af509721"
  license "MIT"
  head "https://github.com/michaelishri/cast-rs.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/michaelishri/homebrew-tap/releases/download/cast-0.9.0"
    sha256 cellar: :any, arm64_tahoe:   "fe0b5d7a50cf48bfb4944e1bb0f7d3737e52ad0e17f30c9d94e2b9a4ff1c0930"
    sha256 cellar: :any, arm64_sequoia: "48e1bc7ea1d157ee60e3a00be03a32488d15ed88bb6f01d7befec8e236e60d30"
    sha256 cellar: :any, arm64_sonoma:  "00ebc9ff008c2c3f214abd36b9c76a28ef91125ad08b7a48006adc09613975c6"
  end

  depends_on "rust" => :build
  depends_on xcode: ["15.0", :build]
  depends_on "ffmpeg"
  depends_on macos: :ventura

  resource "apple-metal" do
    url "https://static.crates.io/crates/apple-metal/apple-metal-0.8.8.crate"
    sha256 "4b1c24b280fad9eadf6f2bf560d826392020ac6258b4c88c6dd356ae7a24f4e3"
  end

  def install
    # apple-metal 0.8.8 compiles optional bridge surfaces that require newer
    # SDKs. Cast only receives frames through screencapturekit and uses none of
    # its Advanced, MetalFX, or sampler APIs.
    resource("apple-metal").stage(buildpath/"vendor/apple-metal")
    inreplace "vendor/apple-metal/swift-bridge/Package.swift",
              'path: "Sources/AppleMetalBridge")',
              'path: "Sources/AppleMetalBridge", exclude: ["Advanced.swift", "MetalFX.swift"])'
    apple_metal_state = "vendor/apple-metal/swift-bridge/Sources/AppleMetalBridge/State.swift"
    reduction_mode = "descriptor.reductionMode = " \
                     "MTLSamplerReductionMode(rawValue: reductionMode) ?? " \
                     "MTLSamplerReductionMode(rawValue: 0)!"
    inreplace apple_metal_state, reduction_mode, ""
    inreplace apple_metal_state, "descriptor.lodBias = lodBias", ""
    File.open("Cargo.toml", "a") do |file|
      file.write <<~TOML

        [patch.crates-io]
        apple-metal = { path = "vendor/apple-metal" }
      TOML
    end

    # Cargo dependencies invoke SwiftPM from their build scripts. Disable its
    # nested sandbox because Homebrew already runs the entire build sandboxed.
    real_swift = Utils.safe_popen_read("xcrun", "--find", "swift").strip
    swift_bin = buildpath/"homebrew-swift-bin"
    swift_bin.mkpath
    swift_wrapper = swift_bin/"swift"
    swift_wrapper.write <<~BASH
      #!/bin/bash
      if [[ "$1" == "build" ]]; then
        shift
        exec "#{real_swift}" build --disable-sandbox "$@"
      fi
      exec "#{real_swift}" "$@"
    BASH
    swift_wrapper.chmod 0755
    ENV.prepend_path "PATH", swift_bin

    system "cargo", "install", *std_cargo_args
    (bin/"cast").ensure_writable do
      MachO::Tools.change_install_name(
        (bin/"cast").to_s,
        "@rpath/libswift_Concurrency.dylib",
        "/usr/lib/swift/libswift_Concurrency.dylib",
      )
    end
    doc.install "LICENSE", "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cast --version")

    (testpath/"invalid.mp4").write "not a media file"
    output = shell_output("#{bin}/cast video --host 127.0.0.1 #{testpath}/invalid.mp4 2>&1", 1)
    assert_match(/could not inspect media container/i, output)
  end
end
