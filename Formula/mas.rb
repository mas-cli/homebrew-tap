# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v4.1.0",
      revision: "4fa8f4c1f5f2ae7e9a554451621d054bba0c7057"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-4.1.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1578bfffe3b8b148a30b34c37d683ff999f09dad3c405ec1ad52257241d84cfd"
    sha256 cellar: :any_skip_relocation, catalina:      "bcf59bd168a0e1ae0eeeed5778335fcbee9ddcca8d6a5d5508f1b232ec5a96bb"
  end

  depends_on xcode: ["16.0", :build]
  depends_on :macos

  def install
    ENV["MAS_DIRTY_INDICATOR"] = ""
    system "Scripts/build", "mas-cli/tap/mas", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/mas"
    system "swift", "package", "--disable-sandbox", "generate-manual"
    man1.install ".build/plugins/GenerateManual/outputs/mas/mas.1"
    bash_completion.install "contrib/completion/mas-completion.bash" => "mas"
    fish_completion.install "contrib/completion/mas.fish"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mas version").chomp
    assert_includes shell_output("#{bin}/mas info 497799835"), "Xcode"
  end
end
