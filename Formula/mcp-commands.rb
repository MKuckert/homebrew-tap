class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.5/mcp-commands_0.9.5_darwin_arm64.tar.gz"
  sha256 "c58b5b3a68f6b4a939cd945d186d1337a05d31c83f2a80938c0d98c0998f03c0"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.5/mcp-commands_0.9.5_darwin_amd64.tar.gz"
    sha256 "c914af0e7198d00ac6bbb9643c9ea434f39ee278eca697c792de6deb7436d6e1"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.9.5/mcp-commands_0.9.5_linux_amd64.tar.gz"
    sha256 "d842382c0126358c0229a5f82dacd9c8d60e2b01d738fc87e13b9ab0347b6e25"
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
