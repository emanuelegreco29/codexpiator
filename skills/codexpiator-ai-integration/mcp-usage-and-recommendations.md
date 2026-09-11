# MCP Usage & Recommendations

## What MCP servers are and why they matter

The Model Context Protocol (MCP) gives an AI agent a standardized way
to access external tools and data — a database, a project management
tool, a design tool, a search index — instead of every integration
being a bespoke, one-off wiring job. This matters because it turns
"give the agent access to X" into a consistent pattern (install/
configure a server, the agent gets a defined set of tools) rather than
custom integration work repeated for every new capability.

## Deciding whether a project needs one

Reach for an MCP server when there's a recurring, real need for an
agent to read or write an external system it can't otherwise reach —
not by default for every project. If the need is a one-off, a direct
API call from application code is often simpler than standing up an
MCP integration for it. If the need is agentic and recurring (an
assistant that regularly needs to query a specific database, manage
tickets in a specific tool, or search a specific knowledge base), an
MCP server is usually the right shape.

## Security considerations specific to MCP

An MCP server is a trust boundary, not a neutral utility:
- **Scope its credentials narrowly** — the same least-privilege
  principle from `agentic-and-tool-use-safety.md` applies directly: an
  MCP server holding a broad credential hands that same broad access
  to anything using it through the protocol.
- **Review what it actually exposes** before connecting it — an MCP
  server can expose more tools/data than a given use case needs; treat
  its tool list the same way you'd review any new dependency's
  permissions.
- **Be wary of MCP servers from unverified sources** — an MCP server
  is executable integration code with real access to whatever it's
  configured against; apply the same supply-chain scrutiny from
  `codexpiator-security/dependency-and-supply-chain.md` before adding
  one, especially a community/third-party one rather than an
  official/well-known provider's.
- **Treat content an MCP tool returns as untrusted data**, not
  instructions — the same prompt-injection discipline from
  `agentic-and-tool-use-safety.md` applies to anything a tool call
  returns, since that content becomes part of the agent's context.

## Documenting a project's MCP dependencies

Keep a short table in the project's README listing every MCP server it
depends on: server name, what it's used for, and what
credentials/scopes it requires. This makes the project's real external
access surface visible at a glance instead of discoverable only by
reading configuration files.

## Project-Specific MCP Recommendations

(This section is intentionally a living list — append specific MCP
server recommendations here as they're identified for concrete use
cases, rather than treating the general guidance above as exhaustive.)
