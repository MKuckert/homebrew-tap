class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.6/mcp-commands_0.9.6_darwin_arm64.tar.gz"
  sha256 "39a0114488d8545b561d326ea17608c1a31b3969b7c9c06fa7f6526f213df427"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.6/mcp-commands_0.9.6_darwin_amd64.tar.gz"
    sha256 "40e1994e9a45a475f7af67e6ec8c563ae5fb1e459fb23b804a1d0e6da1e0db74"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.6/mcp-commands_0.9.6_linux_amd64.tar.gz"
    sha256 "db0c87f5c833feb4b56e2068f2aceb35e22d3b5800a2806b0fb9945c4e84e4a7"
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
