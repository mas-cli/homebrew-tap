# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v4.0.0",
      revision: "21205c013fa941e89463e1d8e553d6e4e3eb8b3f"
  license "MIT"
  revision 1
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-4.0.0_1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ada9522207cd4788417a3e99cd53cb5e86fadcdf4a7d125424b67ab505d7dfd9"
    sha256 cellar: :any_skip_relocation, catalina:      "048e822caa918b0c0a2162c676e325455a10c075f6249c9d251ca96f91486668"
  end

  depends_on xcode: ["16.0", :build]
  depends_on :macos

  def install
    ENV["MAS_DIRTY_INDICATOR"] = ""
    system "Scripts/build", "mas-cli/tap/mas", "--disable-sandbox", "-c", "release"
    mkdir ".build/bin"
    cp "Scripts/mas", ".build/bin/mas"
    cp ".build/release/mas", ".build/bin/mas-bin"
    libexec.install ".build/bin"
    bin.install_symlink "#{libexec}/bin/mas"
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
