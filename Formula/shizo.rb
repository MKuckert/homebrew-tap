class Shizo < Formula
  desc "Fail-closed PreToolUse hook that allowlists Claude Code Bash commands"
  homepage "https://github.com/MKuckert/shizo"
  # Only the platforms with a release archive are supported; on anything
  # else the formula has no url and brew fails loudly at install time.
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/shizo/releases/download/v0.4/shizo_0.4_darwin_amd64.tar.gz"
    sha256 "14e28a85715dbdec626bfa4d69c4a8b2507418ae2ccc2b0274f28ddf2c2fc84a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/MKuckert/shizo/releases/download/v0.4/shizo_0.4_darwin_arm64.tar.gz"
    sha256 "655c1c413f102c94497e907738c6d44959465f539b9398ab7f13b90c5d89ca33"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/shizo/releases/download/v0.4/shizo_0.4_linux_amd64.tar.gz"
    sha256 "c6c8a5efa3bd948c3533336c051aa6a41bdaadd2075d0af7b064d311918b7454"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/MKuckert/shizo/releases/download/v0.4/shizo_0.4_linux_arm64.tar.gz"
    sha256 "3c507ffa12d7b5a9e90881354524dff5e7d08bfb93941e386c50f3724b0b7128"
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
