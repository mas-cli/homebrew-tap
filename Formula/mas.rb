class Mas < Formula
  desc "Mac App Store command-line interface"
  homepage "https://github.com/mas-cli/mas"
  url "https://github.com/mas-cli/mas/archive/v1.4.1.tar.gz"
  sha256 "4fd91c13b46d403b52dbee3891adb3cd6571e07ad20cf58de0100c9f695e6c24"
  head "https://github.com/mas-cli/mas.git"

  bottle do
    root_url "https://dl.bintray.com/phatblat/mas-bottles"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "94452187c379b9ca1a07bae748b89c3124467eff1e44932a7936d07da72682b5" => :high_sierra
    sha256 "94452187c379b9ca1a07bae748b89c3124467eff1e44932a7936d07da72682b5" => :sierra
    sha256 "94452187c379b9ca1a07bae748b89c3124467eff1e44932a7936d07da72682b5" => :el_capitan
    sha256 "94452187c379b9ca1a07bae748b89c3124467eff1e44932a7936d07da72682b5" => :yosemite
    sha256 "94452187c379b9ca1a07bae748b89c3124467eff1e44932a7936d07da72682b5" => :mavericks
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
