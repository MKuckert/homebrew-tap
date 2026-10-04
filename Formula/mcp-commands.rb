class McpCommands < Formula
  desc "MCP server that turns local executable scripts into MCP tools"
  homepage "https://github.com/MKuckert/mcp-commands"
  license :mit
  version "0.8.3"

  on_arm do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.8.3/mcp-commands_darwin_arm64.tar.gz"
    sha256 "5eac95beea35647d5b809a9545521bc0585dca739511018a539ef50e257326d1"
  end

  on_intel do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.8.3/mcp-commands_darwin_amd64.tar.gz"
    sha256 "39081eeea11c6c013afa0885ea6e8178f84a97a76378f4c546a1658cadb44554"
  end

  on_linux do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.8.3/mcp-commands_linux_amd64.tar.gz"
    sha256 "b84b1a02ac37a21880e847732cf7495151fdf06a356288f7deb9f68290062cfe"
  end

  def install
    bin.install "mcp-commands"
  end

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases/latest"
    regex /v?(\d+(?:\.\d+)+)/i
  end

  test do
    assert_match /\d+\.\d+\.\d+/, shell_output("#{bin}/mcp-commands --version")
  end
end
