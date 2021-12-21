class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v1.8.6",
      revision: "560c89af2c1fdf0da9982a085e19bb6f5f9ad2d0"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/mas/releases/download/v1.8.6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
    sha256 cellar: :any_skip_relocation, monterey:       "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
    sha256 cellar: :any_skip_relocation, big_sur:        "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
    sha256 cellar: :any_skip_relocation, catalina:       "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
    sha256 cellar: :any_skip_relocation, mojave:         "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
    sha256 cellar: :any_skip_relocation, high_sierra:    "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
    sha256 cellar: :any_skip_relocation, sierra:         "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
    sha256 cellar: :any_skip_relocation, el_capitan:     "0d042a450d2623e3ea40db0b645454ee88d1a1763a7aa778eec5beea619b9a60"
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
