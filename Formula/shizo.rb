class Shizo < Formula
  desc "Fail-closed PreToolUse hook that allowlists Claude Code Bash commands"
  homepage "https://github.com/MKuckert/shizo"
  # Only the platforms with a release archive are supported; on anything
  # else the formula has no url and brew fails loudly at install time.
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/shizo/releases/download/v0.6/shizo_0.6_darwin_amd64.tar.gz"
    sha256 "1b98f21478fb1811516ba45ddb9fc5d3f822dd6e74999d095f77a54fac1073ca"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/MKuckert/shizo/releases/download/v0.6/shizo_0.6_darwin_arm64.tar.gz"
    sha256 "0657a7c1e462b0a1b93bfe6466ba8137a5fc455223e2db2acbf4b9c405fd4257"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/MKuckert/shizo/releases/download/v0.6/shizo_0.6_linux_amd64.tar.gz"
    sha256 "3c976e35ce64919b1ab915e321b73dbe6c04475ae56d48a9d9feae9954a16ba1"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/MKuckert/shizo/releases/download/v0.6/shizo_0.6_linux_arm64.tar.gz"
    sha256 "681f34d45433aa536b4f73fa36f0c3cb51799d5d8c4e9dfd3260aea0cfdd90a6"
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
    # The release archive ships shizo.sh without the exec bit; the hook
    # command is invoked directly, so restore it.
    bin.install "shizo", "shizo.sh"
    (bin/"shizo.sh").chmod 0755
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
    assert_predicate bin/"shizo.sh", :executable?
    assert_path_exists pkgshare/"conf/global-rules.starter"
  end
end
