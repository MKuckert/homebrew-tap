class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.12.0/mcp-commands_0.12.0_darwin_amd64.tar.gz"
    sha256 "03d023b133e787a14405ce105fa553d65790311939c336261dba3c6be9c57196"
  elsif OS.linux?
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.12.0/mcp-commands_0.12.0_linux_amd64.tar.gz"
    sha256 "88161b5a169e4511ec540bf2d22f0c1f5072f784ed50d11d95caebc30861030f"
  else
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.12.0/mcp-commands_0.12.0_darwin_arm64.tar.gz"
    sha256 "211c97ca6b9c45b27b5085bc336980bbafcc2509e5704b0a4345da0bacef345e"
  end
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  depends_on "fish" => :test
  depends_on "zsh" => :test

  def install
    bin.install "mcp-commands"

    bash_completion.install "completion/mcp-commands.bash" => "mcp-commands"
    zsh_completion.install "completion/mcp-commands.zsh" => "_mcp-commands"
    fish_completion.install "completion/mcp-commands.fish"
  end

  test do
    system bin/"mcp-commands", "--version"

    # The completion scripts ship in every release archive and land in
    # Homebrew's standard completion locations.
    assert_path_exists etc/"bash_completion.d/mcp-commands"
    assert_path_exists share/"zsh/site-functions/_mcp-commands"
    assert_path_exists share/"fish/vendor_completions.d/mcp-commands.fish"

    # Source each installed script to prove it is valid in its shell
    # (the zsh file's compdef registration is guarded, so a plain
    # `zsh -c` source without compinit is safe).
    system "bash", "-c", ". #{etc}/bash_completion.d/mcp-commands"
    system "zsh", "-c", ". #{share}/zsh/site-functions/_mcp-commands"
    system "fish", "-c", "source #{share}/fish/vendor_completions.d/mcp-commands.fish"
  end
end
