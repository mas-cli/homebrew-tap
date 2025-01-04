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
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-1.9.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f190e7bba2cb4dd658ecb2609394404ce7eb59f38946b6530ca490a74f9a7453"
    sha256 cellar: :any_skip_relocation, high_sierra:   "c221899822f317dafe6d2e711055585278a2fdda8acb624030ff530059b5c5a4"
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
