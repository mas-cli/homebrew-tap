class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas/archive/v1.4.1.tar.gz"
  sha256 "4fd91c13b46d403b52dbee3891adb3cd6571e07ad20cf58de0100c9f695e6c24"
  head "https://github.com/mas-cli/mas.git"

  bottle do
    root_url "https://dl.bintray.com/phatblat/mas-bottles"
    cellar :any_skip_relocation
    sha256 "a59ffe6b34ad251fcb57dbea5ba2d0e3d7319fea8cb6543fdef80b9961343cf6" => :high_sierra
    sha256 "a59ffe6b34ad251fcb57dbea5ba2d0e3d7319fea8cb6543fdef80b9961343cf6" => :sierra
    sha256 "a59ffe6b34ad251fcb57dbea5ba2d0e3d7319fea8cb6543fdef80b9961343cf6" => :el_capitan
    sha256 "a59ffe6b34ad251fcb57dbea5ba2d0e3d7319fea8cb6543fdef80b9961343cf6" => :yosemite
    sha256 "a59ffe6b34ad251fcb57dbea5ba2d0e3d7319fea8cb6543fdef80b9961343cf6" => :mavericks
  end

  pour_bottle? do
    reason "macOS 10.12 (Sierra) and Xcode 9.0 are required to build from source."
    satisfy { MacOS.version < :sierra }
  end

  depends_on :xcode => ["9.0", :build]

  def install
    xcodebuild "-project", "mas-cli.xcodeproj",
               "-scheme", "mas-cli Release",
               "-configuration", "Release",
               "SYMROOT=build"
    bin.install "build/mas"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mas version").chomp
  end
end
