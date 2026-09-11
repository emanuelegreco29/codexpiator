# SEO & Launch-Readiness Checklist

A site can be functionally correct and still fail on launch day for
reasons that have nothing to do with its features: missing metadata,
default placeholder pages, no legal pages, a URL that still points at
a default hosting domain. This file is a pre-launch checklist — run
through it before calling a frontend "done," not just before the
first public launch (it applies just as much to a new page added
later).

## Identity & indexing

- [ ] **No default hosting URL exposed as the real address** — no
  `*.vercel.app`/similar placeholder domain linked from anywhere a
  user or search engine would find it once a real domain exists.
- [ ] **Custom 404 page** — not the framework's default/blank error
  page; it should help the user get back to something useful.
- [ ] **`view-source` sanity check** — view the rendered page source
  and confirm the content that matters (title, meta tags, primary
  content for SEO-relevant pages) is actually present in what gets
  served, not only injected client-side after hydration if the page
  needs to be indexed.
- [ ] **No duplicate `<title>` across pages** — every page has a
  distinct, descriptive `<title>` (this is also a real SEO signal, not
  just a UX nicety).
- [ ] **Per-page meta title and meta description** — set individually
  per route, not one global value reused everywhere.
- [ ] **`og:image` and full Open Graph tags per page** — so links
  shared on social/chat platforms render a real preview instead of a
  blank/default card.
- [ ] **Structured data (JSON-LD)** where relevant (articles, products,
  organizations) so search engines can render rich results.
- [ ] **Exactly one `<h1>` per page**, describing that page's primary
  content — not zero, not several competing ones.
- [ ] **Canonical tag** on pages reachable via more than one URL
  (query params, trailing slash variants) to avoid duplicate-content
  SEO issues.
- [ ] **`robots.txt`** present and not accidentally blocking pages you
  want indexed (or, for a pre-launch/staging deployment, correctly
  blocking everything).
- [ ] **`sitemap.xml`** present and kept in sync with real routes.
- [ ] **`llms.txt`** considered for sites that want to guide AI
  crawlers/assistants toward the content they should use.
- [ ] **Favicon** set (including the larger sizes used by mobile home
  screens/PWA install), not the framework default.
- [ ] **`lang` attribute** set correctly on `<html>` for the page's
  actual language.
- [ ] **Alt text on every meaningful image** (full detail in
  `accessibility.md`).

## Shipping hygiene

- [ ] **No source maps served in production** unless deliberately
  intended for error-tracking tooling with restricted access — an
  exposed source map hands out your original, unminified source
  (security angle: see `codexpiator-security/secrets-and-config-management.md`
  for why this can also leak more than just code structure).
- [ ] **No console errors/warnings** on a normal page load — an error
  a developer has gotten used to ignoring is still a real bug from a
  user's perspective.
- [ ] **No massive, unsplit JS bundles** — see
  `frontend-performance.md` for code-splitting; verify with an actual
  bundle analysis, not an assumption.
- [ ] **Compressed images** — see `frontend-performance.md`'s image
  optimization section; verify actual served file sizes.

## Conversion & UX essentials

- [ ] **A CTA visible above the fold** on any page whose job is to
  drive an action (landing pages, product pages) — don't make the
  user scroll to discover what they're supposed to do.
- [ ] **A sticky mobile CTA** where a page's primary action would
  otherwise scroll out of view on small screens.
- [ ] **Loading states and skeletons** for anything that fetches data
  before rendering — a blank screen during a fetch reads as broken,
  not loading.
- [ ] **Form error states** wired up per `forms-and-validation.md`,
  not just a generic "something went wrong."
- [ ] **Toast/message feedback** for actions that succeed or fail
  without a full page navigation (saved, deleted, error) so the user
  isn't left guessing whether something happened.
- [ ] **A real "thank you" / confirmation page or state** after a
  meaningful action (signup, purchase, submission) — not a silent
  success with no acknowledgment.

## Legal & trust essentials

- [ ] **Privacy policy page**, linked from the footer at minimum.
- [ ] **Terms of service page**.
- [ ] **Cookie policy page** and, where legally required for the
  audience, a **cookie consent banner** wired to actually gate
  non-essential tracking until consent is given.
- [ ] **VAT/company registration details in the footer** where legally
  required for the business's jurisdiction.
- [ ] **A real, reachable contact address/method** — not a placeholder
  email or a contact form that goes nowhere.
- [ ] **Analytics actually installed and verified firing**, not just
  added to the code and assumed to work — check it's recording real
  events before considering the integration done.

## Responsive baseline

- [ ] **Mobile breakpoints actually tested**, not just assumed from
  desktop layout shrinking gracefully — see
  `responsive-and-mobile.md`.
