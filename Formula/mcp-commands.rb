class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  license :mit
  # One-time seed values; the first automated bump removes this line.
  version "0.8.3"
  # Primary platform: macOS arm64. Other platforms download via resources.
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.8.3/mcp-commands_darwin_arm64.tar.gz"
  sha256 "5eac95beea35647d5b809a9545521bc0585dca739511018a539ef50e257326d1"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(/href=.*?releases\/download\/v?(\d+(?:\.\d+)+)\.*/i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.8.3/mcp-commands_darwin_amd64.tar.gz"
    sha256 "39081eeea11c6c013afa0885ea6e8178f84a97a76378f4c546a1658cadb44554"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.8.3/mcp-commands_linux_amd64.tar.gz"
    sha256 "b84b1a02ac37a21880e847732cf7495151fdf06a356288f7deb9f68290062cfe"
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
