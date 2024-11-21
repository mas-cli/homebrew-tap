# typed: strict
# frozen_string_literal: true

# mas command formula for custom tap (mas-cli/homebrew-tap).
class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas.git",
      tag:      "v1.8.7",
      revision: "4405807010987802c0967bbf349c08808062b824"
  license "MIT"
  head "https://github.com/mas-cli/mas.git", branch: "main"

  bottle do
    root_url "https://github.com/mas-cli/mas/releases/download/v1.8.7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, sonoma:         "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, ventura:        "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, monterey:       "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, big_sur:        "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, catalina:       "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, mojave:         "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, high_sierra:    "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, sierra:         "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
    sha256 cellar: :any_skip_relocation, el_capitan:     "5d0214faef2a956c72a4c610ff73ecec0ffa14555547a48e50a4432f1c655565"
  end

  depends_on xcode: ["14.2", :build]
  depends_on :macos

  def install
    system "script/build"
    bin.install ".build/release/mas"

    bash_completion.install "contrib/completion/mas-completion.bash" => "mas"
    fish_completion.install "contrib/completion/mas.fish"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mas version").chomp
    assert_includes shell_output("#{bin}/mas info 497799835"), "Xcode"
  end
end
