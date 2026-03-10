# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v6.0.1",
      revision: "535562b304eb110700eb57f289317f7b5c41cb2d"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-6.0.0_1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "996eba6102ebb760ad9600760fa6de87c1631d0676b45545b7ea73e09af79524"
    sha256 cellar: :any_skip_relocation, ventura:       "c9968a7410beeca81b4fec208f5e62ea0178e2f7c9c927e60f0ba4fb59a219c5"
  end

  depends_on :macos

  uses_from_macos "swift" => :build, since: :sequoia # swift 6.2+

  on_sequoia :or_newer do
    depends_on xcode: ["26.0", :build]
  end

  on_sonoma :or_older do
    depends_on "swift" => :build
  end

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
