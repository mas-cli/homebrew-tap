# 🍻🚰📦 mas Homebrew Tap

Bottles of mas for older versions of macOS.

# 🤳🏼 Usage

Run the following command to install `mas` from this custom tap:

```bash
brew install mas-cli/tap/mas
```

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "mas-cli/tap"
brew "mas"
```

If you want to remove this formula & custom tap (possibly before switching to the `mas` formula from `homebrew-core`):

```bash
$ brew uninstall mas-cli/tap/mas
$ brew untap mas-cli/tap
```

# 📄 License

This repo is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for rights and limitations.
