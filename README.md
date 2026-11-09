# MKuckert/homebrew-tap

Homebrew tap for:

- [mcp-commands](https://github.com/MKuckert/mcp-commands) — an MCP server
  that turns local executable scripts into MCP tools.
- [shizo](https://github.com/MKuckert/shizo) — a fail-closed `PreToolUse` hook
  that allowlists Claude Code Bash commands at subcommand granularity.

## Installation

```bash
brew trust --formula MKuckert/homebrew-tap/mcp-commands
brew install MKuckert/homebrew-tap/mcp-commands

brew trust --formula MKuckert/homebrew-tap/shizo
brew install MKuckert/homebrew-tap/shizo
```

(`brew trust` is required once for non-core taps under current Homebrew.)

shizo reads its rules from `~/.shizo`, which Homebrew cannot create; after
installing, follow the steps printed by `brew info shizo` to set up the
starter rules and register the hook.

## Maintenance

The formulae are maintained automatically: after each release of
`MKuckert/mcp-commands` or `MKuckert/shizo`, the upstream release workflow
dispatches a `release-bumped` event to this repository, and the
`bump-formula` workflow rewrites the formula's URLs and checksums and commits
the result. The event's `client_payload` carries the release `tag` and the
`formula` name (`mcp-commands` or `shizo`; defaults to `mcp-commands`).

The `test-formula` workflow runs `brew test` and `brew audit` for every
formula on each push and pull request, and verifies that each release URL
matches its checksum.
