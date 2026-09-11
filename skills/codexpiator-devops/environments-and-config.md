# Environments & Config

## Environment parity

Keep dev, staging, and production as similar as possible — same
database engine, same major dependency versions, same general
architecture — differing mainly in scale and data. A staging
environment that diverges significantly from production (different
database, disabled security settings, mock third-party services)
stops being a reliable signal that "it worked in staging" means
anything about production.

## Config via environment, not hardcoded

Any value that differs by environment (API base URLs, feature toggles,
resource limits, credentials) belongs in environment variables or a
config service, read at startup — never hardcoded with an `if
environment == 'production'` branch scattered through application
code. This is the practical core of 12-factor-app config: the same
build artifact runs correctly in any environment purely by changing
its configuration, not its code.

## Feature flags decouple deploy from release

A feature flag lets you deploy code to production without exposing it
to users yet (deploy dark), then enable it separately (release) —
often gradually, or for specific users first. This separates "is the
code safely in production" from "is the feature live for users,"
which makes both questions easier to answer and de-risks both steps.

## Secrets: handled elsewhere, linked here

Secret values (API keys, database credentials) follow the practices in
`codexpiator-security/secrets-and-config-management.md` — this file
covers general config; that one covers what changes when the config
value is sensitive.
