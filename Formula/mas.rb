class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v1.8.4",
      revision: "02ceea49cd39717f26c2e1117ac4ef07385736fa"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/mas/releases/download/v1.8.4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
    sha256 cellar: :any_skip_relocation, monterey:       "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
    sha256 cellar: :any_skip_relocation, big_sur:        "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
    sha256 cellar: :any_skip_relocation, catalina:       "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
    sha256 cellar: :any_skip_relocation, mojave:         "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
    sha256 cellar: :any_skip_relocation, high_sierra:    "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
    sha256 cellar: :any_skip_relocation, sierra:         "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
    sha256 cellar: :any_skip_relocation, el_capitan:     "99b47db5ad006eada492511e1a4de5ff63b2e46b05a8e3b253f59f9e13a0e585"
  end

  depends_on :macos
  if Hardware::CPU.arm?
    depends_on xcode: ["12.2", :build]
  else
    depends_on xcode: ["12.0", :build]
  end

  def install
    system "script/build", "--universal"
    system "script/install", "--universal", prefix

    bash_completion.install "contrib/completion/mas-completion.bash" => "mas"
    fish_completion.install "contrib/completion/mas.fish"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mas version").chomp
    assert_includes shell_output("#{bin}/mas info 497799835"), "Xcode"
  end
end
