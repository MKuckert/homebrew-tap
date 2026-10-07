class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.11.0/mcp-commands_0.11.0_darwin_arm64.tar.gz"
  sha256 "c2d624f88d8d315bb19355b14b9e3f3f76ce063eb97d600b7865ce185476797f"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.11.0/mcp-commands_0.11.0_darwin_amd64.tar.gz"
    sha256 "67f51e1ffcffc5c90592945104dc8b86486a1ee314d268d35165770efd670105"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.11.0/mcp-commands_0.11.0_linux_amd64.tar.gz"
    sha256 "39a0afbb6df753b439aaad45a0cff940c41952ad2a4013fd4b2583cc2e9976f9"
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
