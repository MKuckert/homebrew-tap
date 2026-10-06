class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.10.0/mcp-commands_0.10.0_darwin_arm64.tar.gz"
  sha256 "e3d40ddf4c797b5607c0e8a3e31c1f453b9f74fc0bb4df212207baca480c34e9"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.10.0/mcp-commands_0.10.0_darwin_amd64.tar.gz"
    sha256 "d7328086471128e6a0160530d35d1273cc0272e2b7fd4d988de463173e0c3dc2"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.10.0/mcp-commands_0.10.0_linux_amd64.tar.gz"
    sha256 "9181949b76114ffb752ea13487293656e16f06a02268eaac729c745fd38e830e"
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
