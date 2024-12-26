# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v1.8.8-beta.30",
      revision: "cfab6a4c06b9735db7a9753e322e6c895a9e4c22"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-1.8.8-beta.13"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "98fa68b6b80a59dc81e01154fb49917fdde19814573592bf12d428a2e9021d6b"
    sha256 cellar: :any_skip_relocation, ventura:       "2fb701e792bad845b6800c8008fa303276e29a8438f6b5c5bd4ea57abed860ce"
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
