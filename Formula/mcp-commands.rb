class McpCommands < Formula
  desc "CLI tool that converts CLI commands into Model Context Protocol resources"
  homepage "https://github.com/MKuckert/mcp-commands"
  # Only the platforms with a release archive are supported; on anything
  # else the formula has no url and brew fails loudly at install time.
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.13.0/mcp-commands_0.13.0_darwin_amd64.tar.gz"
    sha256 "7ad9efd23d32169f9eb184030030f7fcbbcc8e0ce908d62468b53bda8c60d1ff"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.13.0/mcp-commands_0.13.0_darwin_arm64.tar.gz"
    sha256 "6a6c83abb40a14e1cbfede4a8bcf6c58dde8e9a500ac6bbc7ab46e015c7f1e7e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/mcp-commands/releases/download/v0.13.0/mcp-commands_0.13.0_linux_amd64.tar.gz"
    sha256 "a9a1c70ae007e2bada08d93cd9700a379d26728f5c254030a12aecad1ab48a78"
  end
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/mcp-commands/releases"
    # GitHub renders the asset list client-side, so the static HTML only
    # contains /releases/tag/ links (no /releases/download/).
    regex(%r{href=.*?releases/tag/v?(\d+(?:\.\d+)+)\.*}i)
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
