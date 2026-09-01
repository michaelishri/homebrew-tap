# Michaelishri Homebrew Tap

Homebrew formulae maintained by Michael Ishri.

## Install Cast

Install the Cast command-line interface:

```sh
brew install michaelishri/tap/cast
```

Install the Cast menu-bar application on macOS:

```sh
brew install --cask michaelishri/tap/cast-desktop
```

Alternatively, tap the repository first:

```sh
brew tap michaelishri/tap
brew install cast
brew install --cask cast-desktop
```

In a `Brewfile`:

```ruby
tap "michaelishri/tap"
brew "cast"
cask "cast-desktop"
```

Cast documentation and source code live at
[michaelishri/cast-rs](https://github.com/michaelishri/cast-rs).
