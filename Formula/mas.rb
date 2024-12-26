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
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-1.8.8-beta.31"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e9f1e5edc49604fcb9a97b47deea1a4c7d4841f51d78c03dd0863b6ec3551a0e"
    sha256 cellar: :any_skip_relocation, high_sierra:   "e621225c56a8c1e6b0ac3cc31dec9f1be80fb303b4b4b177eaeb9b905903076f"
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
