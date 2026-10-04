class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.0/mcp-commands_0.9.0_darwin_arm64.tar.gz"
  sha256 "1a14df3af9e74364a946f41625f81c95213d9910d8f6b5066d2c4d82d203027c"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.0/mcp-commands_0.9.0_darwin_amd64.tar.gz"
    sha256 "7469bf885598816780835371e1fb09d4ba1541c620dbd2ff2a4c698bd85b63e5"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.0/mcp-commands_0.9.0_linux_amd64.tar.gz"
    sha256 "b7f0608b73aaf23efac2a38236a619f78e26a150d0d63713d1b9ad004a6042c3"
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
