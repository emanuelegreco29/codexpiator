# Auth & Authorization

## Authentication vs authorization

Authentication answers "who are you" (logging in, verifying identity).
Authorization answers "what are you allowed to do" (permissions,
roles, ownership checks). Keep them conceptually and often
structurally separate — a system can correctly authenticate someone
and still need a completely independent check before letting them
read or modify a specific resource.

## Session-based vs token-based (JWT)

Server-side sessions (a session ID in a cookie, session data stored
server-side) make revocation trivial (delete the session record) and
keep sensitive claims off the client, at the cost of needing shared
session storage across server instances. JWTs (a signed token holding
claims, verified without a server-side lookup) are stateless and scale
horizontally without shared storage, at the cost of being hard to
revoke before they expire (the server can't "delete" a token it never
stored). Mitigate JWT revocation difficulty with short expiry times
plus a refresh-token flow (a separate, revocable long-lived token used
to mint new short-lived access tokens). Neither is universally
"more secure" — pick based on whether easy revocation or stateless
scaling matters more for the system.

## Password storage

Hash passwords with a purpose-built slow hash function (bcrypt,
scrypt, or argon2) with a per-password salt (these libraries handle
salting for you) — never a fast general-purpose hash (MD5, SHA-256
alone) and never a custom scheme. A fast hash makes brute-forcing
leaked hashes cheap; a slow, purpose-built one makes it expensive by
design. This is not an area to improvise in — use a well-reviewed
library's default settings.

## Least-privilege role/permission modeling

Grant the minimum access a role actually needs to do its job, and
model permissions explicitly (a role/permission table, or equivalent)
rather than checking scattered boolean flags (`isAdmin`) throughout
the codebase — explicit modeling makes it possible to answer "who can
do X" by looking in one place, and to add a new intermediate
permission level later without restructuring every check.

## This file vs `codexpiator-security`

This file is the practical how-to for implementing auth. For the
threat-model side — session fixation, horizontal privilege escalation,
MFA posture, and the broader security checklist — see
`codexpiator-security/authn-authz-patterns.md`. Use both together when
building anything auth-related; they cover different halves of the
same concern.
