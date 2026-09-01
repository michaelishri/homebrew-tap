cask "cast-desktop" do
  arch arm: "arm64", intel: "x86_64"

  version "0.12.0"
  sha256 arm:   "0be0686a37931e4c4d06b4526bd18911e399d4a5981ab967b513f7766b2b264a",
         intel: "bfa087d67c99bdcb3c8815b886fafdc9f67fc1b95a68caa9f9718f0cec72f65e"

  url "https://github.com/michaelishri/cast-rs/releases/download/v#{version}/cast-#{version}-macos-#{arch}.tar.gz"
  name "Cast"
  desc "Cast displays to Google Cast receivers from the menu bar"
  homepage "https://github.com/michaelishri/cast-rs"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "cast-#{version}-macos-#{arch}/Cast.app"

  uninstall quit: "io.github.michaelishri.cast"

  zap trash: [
    "~/Library/Preferences/io.github.michaelishri.cast.plist",
    "~/Library/Saved Application State/io.github.michaelishri.cast.savedState",
  ]

  caveats <<~EOS
    Cast.app is ad-hoc signed but is not Developer ID signed or notarized. If
    macOS blocks the first launch, open System Settings > Privacy & Security
    and choose Open Anyway.

    Desktop casting requires Screen Recording and Local Network permission.
  EOS
end
