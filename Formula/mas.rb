# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v2.2.2",
      revision: "7dacbbf3fb9a622247c1b0b9f18a4a9c7673ee53"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-2.2.1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "80d3d6f54356eac4a962c90c40f442a83161c49ff241d4cb25eb4c00352eec67"
    sha256 cellar: :any_skip_relocation, catalina:      "9e0a141cfe82c4e8ea62f29617c2d6e403c43fb99cc1f4bf022864586ecf48e0"
  end

  depends_on xcode: ["15.0", :build]
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
