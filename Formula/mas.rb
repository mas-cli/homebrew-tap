# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v1.9.0",
      revision: "a5a928a2e6a28a5c751bca7f63f26b06cede8197"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-1.8.8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a351d3c4ebca069ff04e79c30b420b2eb0c07e67a8143cefc3785df5af0326af"
    sha256 cellar: :any_skip_relocation, high_sierra:   "45bcda814053cf98d7e0520bcf9e25d6ebbb85d727b9ac5f4d1fe5ae89a0c1c0"
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
