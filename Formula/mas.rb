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
    root_url "https://github.com/mas-cli/homebrew-tap/releases/download/mas-4.0.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3c1456812acdfbf473a508c8d696414cb6e760c25bbfdf1de78a1a1a013aa7e0"
    sha256 cellar: :any_skip_relocation, catalina:      "718c8979cba859a9fd37b56a18b27cfd44ae7d003327a1f52612ae850ea897ef"
  end

  depends_on xcode: ["15.0", :build]
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
