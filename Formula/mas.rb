# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v2.1.0",
      revision: "a4756e8c82a2bae5d5de1b137ec16fa7c1df8c94"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-2.1.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "11c734779d4e6699e27f31f25b2b51f8048ce2590cc142b1ddb7d79662a79b46"
    sha256 cellar: :any_skip_relocation, catalina:      "f36052a454ff64e9847f505a51e4d2166969248b563a2e8a787a27170f6a3a10"
  end

  depends_on xcode: ["14.2", :build]
  depends_on :macos

  def install
    ENV["MAS_DIRTY_INDICATOR"] = ""
    system "script/build", "mas-cli/tap/mas", "--disable-sandbox"
    bin.install ".build/release/mas"

    bash_completion.install "contrib/completion/mas-completion.bash" => "mas"
    fish_completion.install "contrib/completion/mas.fish"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mas version").chomp
    assert_includes shell_output("#{bin}/mas info 497799835"), "Xcode"
  end
end
