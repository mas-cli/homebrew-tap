# 🍻🚰📦 mas Homebrew Tap

Here you'll find bottles of mas for older versions of macOS.

# 🤳🏼 Usage

Use the following commands to add this tap to your local Homebrew installation.

```
$ brew tap mas-cli/mas
$ brew tap-pin mas-cli/mas
$ brew install mas
```

The [`tap-pin` command](https://docs.brew.sh/Taps#formula-duplicate-names)
is necessary since mas is already included in the core tap of Homebrew. A pinned tap's
formulae take precedence over duplicates in other taps.

You can review the repos you have tapped and pinned using the following commands.

```
$ brew tap
caskroom/cask
mas-cli/mas
$ brew tap --list-pinned
mas-cli/mas
```

If you want to switch back to the core mas formula, you can unpin this tap.

```
$ brew tap-unpin mas-cli/mas
```

# 📄 License

This repo is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for rights and limitations.
