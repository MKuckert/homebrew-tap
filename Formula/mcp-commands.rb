class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  url "https://github.com/MKuckert/mcp-commands/releases/download/v0.11.1/mcp-commands_0.11.1_darwin_arm64.tar.gz"
  sha256 "c65559f8434511691d4a99385a0c92e0e15654e0fed2ed22bc32e55b7ae9718d"
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    regex(%r{href=.*?releases/download/v?(\d+(?:\.\d+)+)\.*}i)
  end

  depends_on "fish" => :test
  depends_on "zsh" => :test

  resource "darwin_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.11.1/mcp-commands_0.11.1_darwin_amd64.tar.gz"
    sha256 "1b53e91f164a8b2a417208affdda8bc5d8052f44ccbf93f5404e3cec6386ec4a"
  end

  resource "linux_amd64" do
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.11.1/mcp-commands_0.11.1_linux_amd64.tar.gz"
    sha256 "4e292a5c54c8e371f3c4779ab67208f95b99f6e6a5b04cf7242da98a9d006e0b"
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      resource("darwin_amd64").stage { bin.install "mcp-commands" }
    elsif OS.linux?
      resource("linux_amd64").stage { bin.install "mcp-commands" }
    else
      bin.install "mcp-commands"
    end

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
