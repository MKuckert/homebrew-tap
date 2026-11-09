class Shizo < Formula
  desc "Fail-closed PreToolUse hook that allowlists Claude Code Bash commands"
  homepage "https://github.com/MKuckert/shizo"
  # Only the platforms with a release archive are supported; on anything
  # else the formula has no url and brew fails loudly at install time.
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/shizo/releases/download/v0.5/shizo_0.5_darwin_amd64.tar.gz"
    sha256 "eab333fb73d9ff0817d893bd1ada02b7a9c3bce70f0a070ba144843e1c9e95ce"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/MKuckert/shizo/releases/download/v0.5/shizo_0.5_darwin_arm64.tar.gz"
    sha256 "e75decc0a2581391adfbb0fe9de05feaa80b36b4405ab89e799da8112b96b012"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/shizo/releases/download/v0.5/shizo_0.5_linux_amd64.tar.gz"
    sha256 "cc330108b1424da3dee6afd2cb6fc12135bbccd1acb1ca9979eac6bffa0ded49"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/MKuckert/shizo/releases/download/v0.5/shizo_0.5_linux_arm64.tar.gz"
    sha256 "25290f94bed0da89e8756d9f07f25fae77ba09cb8a0adc42f5cd5c4500643f54"
  end
  license "MIT"

  livecheck do
    url "https://github.com/MKuckert/shizo/releases"
    # GitHub renders the asset list client-side, so the static HTML only
    # contains /releases/tag/ links (no /releases/download/).
    regex(%r{href=.*?releases/tag/v?(\d+(?:\.\d+)+)\.*}i)
  end

  def install
    # shizo.sh locates the binary next to itself, so both live in bin.
    bin.install "shizo", "shizo.sh"
    # Starter rules, example sandbox profile, editor grammar, pi extension.
    pkgshare.install "conf"
  end

  def caveats
    <<~EOS
      shizo reads its policy from ~/.shizo. Create the starter rules and
      register the hook with:

        mkdir -p ~/.shizo/global ~/.shizo/logs ~/.shizo/attestations
        cp #{opt_pkgshare}/conf/global-rules.starter ~/.shizo/global/rules
        shizo attest --global
        shizo install claude-hook --global

      The hook command is #{opt_bin}/shizo.sh. Your sandbox must grant
      read access to it and to ~/.shizo, and write access to ~/.shizo/logs.
    EOS
  end

  test do
    assert_match "shizo", shell_output("#{bin}/shizo --version")
    assert_path_exists bin/"shizo.sh"
    assert_path_exists pkgshare/"conf/global-rules.starter"
  end
end
