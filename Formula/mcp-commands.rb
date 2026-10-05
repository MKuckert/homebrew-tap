class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.4/mcp-commands_0.9.4_darwin_arm64.tar.gz"
  sha256 "38ccf5a6f463bdc9e18b851c847125427b0ca9f946d47ca517f6269381982cf2"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.4/mcp-commands_0.9.4_darwin_amd64.tar.gz"
    sha256 "be2d53e302540b39f8a7352ae7eb2df21c6a5c0756f0c9e4e4dd3b3c2dc6ad4d"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.4/mcp-commands_0.9.4_linux_amd64.tar.gz"
    sha256 "a1c9544a083d571d9a81794b1186da5256f1269eea23815c654eb20c05d257e4"
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      resource("darwin_amd64").stage { bin.install "mcp-commands" }
    elsif OS.linux?
      resource("linux_amd64").stage { bin.install "mcp-commands" }
    else
      bin.install "mcp-commands"
    end
  end

  test do
    system bin/"mcp-commands", "--version"
  end
end
