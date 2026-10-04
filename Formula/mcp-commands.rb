class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.2/mcp-commands_0.9.2_darwin_arm64.tar.gz"
  sha256 "bf9d0ceb132d2f2ba9f7377b12b794a36f85fe6d5ed0f7d7c08e0699a589bf01"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.2/mcp-commands_0.9.2_darwin_amd64.tar.gz"
    sha256 "4edeb48f47e89bef2cea14c8bab3a59b009d1624d088d627c121ff54eeaee464"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.2/mcp-commands_0.9.2_linux_amd64.tar.gz"
    sha256 "1348b9576e24d0963ba9e9027b1e38c1599483bc45bec7e88cf31e1cd7ff18bc"
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
