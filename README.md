# MKuckert/homebrew-tap

Homebrew tap for [mcp-commands](https://github.com/MKuckert/mcp-commands) —
an MCP server that turns local executable scripts into MCP tools.

## Installation

```bash
brew trust --formula MKuckert/homebrew-tap/mcp-commands
brew install MKuckert/homebrew-tap/mcp-commands
```

(`brew trust` is required once for non-core taps under current Homebrew.)

## Maintenance

The formula is maintained automatically: after each `MKuckert/mcp-commands`
release, the upstream release workflow dispatches a `release-bumped` event to
this repository, and the `bump-formula` workflow rewrites the formula's URLs
and checksums and commits the result.
