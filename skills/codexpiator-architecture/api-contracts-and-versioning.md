# API Contracts & Versioning

## A contract is a promise

Once an endpoint has real consumers (an external client, a separate
frontend deployed independently, a mobile app already in users'
hands), its request/response shape is a promise you can't just change
— a breaking change on your side breaks something you may not
control or even be able to see. Treat the contract as something that
changes deliberately and visibly, not as an implementation detail that
happens to be reachable over HTTP.

## Backward-compatible vs breaking changes

**Backward-compatible** (safe to ship without a version bump):
adding a new optional field to a response, adding a new endpoint,
adding a new optional request parameter with a sensible default.
**Breaking** (requires versioning or a deprecation window): removing
or renaming a field, changing a field's type, changing what a status
code means, making a previously-optional parameter required, changing
default behavior in a way existing consumers depend on. When in doubt
about whether a change is breaking, assume it is — the cost of
treating a safe change cautiously is much lower than the cost of
silently breaking a consumer.

## Contract-first design

For anything with external or cross-team consumers, write the
schema/contract (OpenAPI or equivalent) before implementing — this
lets consumers start integrating against a stable shape while the
implementation is still in progress, and forces the contract's design
to be considered deliberately rather than emerging as a byproduct of
whatever the implementation happened to return first.

## Deprecation, not silent removal

When a breaking change is necessary, communicate it explicitly:
mark the old version/field as deprecated with a stated sunset date
(a `Sunset` header, documentation, direct notice to known consumers),
keep it functioning through that window, and only remove it after the
window closes. Silent removal turns a planned change into an incident
for whoever was still depending on it.
