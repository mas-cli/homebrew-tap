# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v1.8.8-beta.32",
      revision: "335eddc90df0e1c967095be5de0d53537795739f"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-1.8.8-beta.32"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f2a58c440106c14e7bec85a0dee232d53c7afc595c3813a4b7f873861cc1caba"
    sha256 cellar: :any_skip_relocation, high_sierra:   "9e96e723aedb0d419ac312eba2cebd90542897f207c1cbf2de2e736eafdcbc06"
  end

  depends_on xcode: ["14.2", :build]
  depends_on :macos

  def install
    system "script/build", "--disable-sandbox"
    bin.install ".build/release/mas"

    bash_completion.install "contrib/completion/mas-completion.bash" => "mas"
    fish_completion.install "contrib/completion/mas.fish"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mas version").chomp
    assert_includes shell_output("#{bin}/mas info 497799835"), "Xcode"
  end
end
