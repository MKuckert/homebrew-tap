class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.3/mcp-commands_0.9.3_darwin_arm64.tar.gz"
  sha256 "7ac44ec82037e649c6ee6a08cb3f6dda8cc1d8dec4b2a3e30b24a322be61038d"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.3/mcp-commands_0.9.3_darwin_amd64.tar.gz"
    sha256 "773e46cec70de1f6ea8ed54e71399c62386b204cede9eb38c9288738d7d29c6e"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.3/mcp-commands_0.9.3_linux_amd64.tar.gz"
    sha256 "a709ade594869f35017cbe14fee10296fba743464b81629707f5d5b89c8e40a4"
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
