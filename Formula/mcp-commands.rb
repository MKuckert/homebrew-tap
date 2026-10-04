class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.1/mcp-commands_0.9.1_darwin_arm64.tar.gz"
  sha256 "2c5d93a6a0c8947fa3a8ec38e4c92abcd508dcd40ccceb407a1b66ecec7c7fd7"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.1/mcp-commands_0.9.1_darwin_amd64.tar.gz"
    sha256 "8da55678ec65de9c63e1bc6449775e42413aaa94d03c97f672f68f040ba4936f"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.1/mcp-commands_0.9.1_linux_amd64.tar.gz"
    sha256 "edeb49d5049b5a42367a99bd1aec0aea4d409c83d8e109ddcdb275fa175780d2"
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
