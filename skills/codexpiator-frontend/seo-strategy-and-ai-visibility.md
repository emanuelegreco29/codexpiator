# SEO Strategy & AI Visibility (GEO)

`seo-and-launch-checklist.md` is the pre-ship checklist. This file is
the deeper strategy behind it: how to actually rank in traditional
search engines (Google, Bing, DuckDuckGo) *and* how to be retrieved
and cited by AI answer engines (ChatGPT, Google AI Overviews,
Perplexity, Claude, Copilot) — a discipline now commonly called GEO
(Generative Engine Optimization) or AEO (Answer Engine Optimization).

## Traditional SEO foundation

### Crawlability and indexability come first

None of the content strategy below matters if search engines can't
crawl and index the page at all. Confirm: `robots.txt` doesn't
accidentally block pages that should be indexed, a `sitemap.xml`
lists real current routes, canonical tags resolve correctly on pages
reachable via multiple URLs, and the page's actual content is present
in server-rendered/initial HTML rather than requiring JavaScript
execution to appear — some crawlers render JS, many don't, and AI
crawlers in particular are inconsistent about it (safest assumption:
critical content should be present without JS execution).

### On-page fundamentals

- One clear, descriptive `<h1>` per page; a logical heading hierarchy
  below it (don't skip levels, don't use headings for visual styling
  alone).
- Unique, specific `<title>` and meta description per page, written
  for the human reader deciding whether to click — not stuffed with
  repeated keywords, which modern search ranking actively discounts.
- Descriptive URLs and internal links (link text that describes the
  destination, not "click here") — internal linking is also how
  crawlers discover the rest of the site's structure and how they
  infer which pages you consider most important.
- Core Web Vitals (loading, interactivity, visual stability — see
  `frontend-performance.md`) are a real, if moderate, ranking factor
  and a direct UX factor regardless of ranking impact.

### Content strategy: intent and depth over keyword density

Write for the actual intent behind a search query (what problem is
someone trying to solve) and answer it thoroughly on one coherent
page, rather than fragmenting the same topic across many thin pages
or repeating a target keyword artificially. Both traditional search
ranking and AI answer engines increasingly reward comprehensive,
well-organized content over keyword-density tricks — this alignment
is a big part of why a strong traditional-SEO content strategy and a
strong GEO strategy overlap so heavily.

### E-E-A-T: experience, expertise, authoritativeness, trust

Content that demonstrates real experience and expertise, comes from an
identifiable, credible source, and is presented trustworthily (accurate,
transparently sourced, kept up to date) is favored both by traditional
search quality systems and by AI systems deciding what to cite. Concretely:
show real authorship/expertise where relevant, cite sources for factual
claims, keep a visible "last updated" date on content that can go stale,
and refresh cornerstone content periodically rather than publishing once
and never revisiting it — AI engines in particular weight recency when
choosing what to cite.

### Structured data (schema.org)

Add structured data so both traditional search results and AI systems
can parse facts about the page reliably instead of inferring them from
prose: `Organization`/`WebSite` for identity, `Article` for content
pages, `Product` for commerce, `BreadcrumbList` for navigation
context, and `FAQPage`/`HowTo` (below) for question-and-answer or
step-by-step content. This is the single highest-leverage technical
addition for helping any automated system — search or AI — understand
the page correctly.

## FAQ strategy

A well-built FAQ section serves three audiences at once: users with a
quick specific question, traditional search (FAQ content frequently
surfaces directly in search results via `FAQPage` structured data),
and AI answer engines (a clear, self-contained question-and-answer
pair is close to ideal shape for an LLM to extract and quote
directly).

- Write real questions users actually ask (support tickets, sales
  questions, common confusion points) — not invented questions that
  exist only to stuff a keyword.
- Answer each question completely and directly in the first sentence
  or two, then elaborate if needed — both a human skimmer and an AI
  extracting an answer benefit from the direct answer coming first,
  not buried after preamble.
- Mark up FAQ content with `FAQPage` JSON-LD structured data so the
  question/answer structure is machine-readable, not just visually
  formatted.
- Keep FAQ content genuinely current — a stale FAQ that no longer
  matches the actual product is a trust signal working against you
  with both users and AI systems judging accuracy.

## GEO: being retrieved and cited by AI answer engines

### How this differs from ranking in ten blue links

Traditional search surfaces roughly ten results; an AI answer
typically cites only two to seven sources for a given answer. GEO is
about earning one of those few citation slots — which makes clear,
extractable, trustworthy content matter even more than in traditional
SEO, since there's far less room and the bar is "worth directly
quoting or citing," not just "relevant enough to list."

### Make sure AI crawlers can actually reach the content

Confirm `robots.txt` doesn't block the crawlers that matter for AI
visibility. As of 2026 the major named AI crawlers include:
`GPTBot`, `OAI-SearchBot`, `ChatGPT-User` (OpenAI); `ClaudeBot`,
`Claude-SearchBot`, `Claude-User` (Anthropic); `Google-Extended`
(Google's AI-training opt-out token, layered on top of standard
`Googlebot` crawling); `PerplexityBot`, `Perplexity-User`
(Perplexity); `Applebot-Extended` (Apple); `Amazonbot` (Amazon);
`Meta-ExternalAgent` (Meta). These generally respect `robots.txt` by
policy. `Bytespider` (ByteDance) is the notable exception with a
documented history of ignoring disallow rules — block it explicitly if
you want to opt out of that particular crawler regardless.

```
# Example robots.txt allowing the major AI crawlers
User-agent: GPTBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: Claude-SearchBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Google-Extended
Allow: /

# ByteDance's crawler has a documented history of ignoring
# disallow rules; block explicitly if you don't want it regardless
User-agent: Bytespider
Disallow: /
```

Decide deliberately whether you *want* AI-training crawlers included
at all — some sites intentionally disallow training crawlers
(`GPTBot`, `Google-Extended`, etc.) while still allowing the
retrieval/search-time bots (`OAI-SearchBot`, `Claude-SearchBot`,
`PerplexityBot`) so they can still be cited in live AI answers without
their content being used for model training. This is a real, legitimate
choice per project — don't allow-all by default without considering it.

### `llms.txt`: use with realistic expectations

`llms.txt` (a plain-text file at the site root summarizing the site
for AI systems) is a proposed convention some tooling supports — it's
reasonable to add since it costs little, but don't treat it as a
guaranteed lever: Google's own public guidance on generative AI search
explicitly lists `llms.txt` and content-chunking tricks as tactics it
considers unnecessary. Treat it as a low-cost nice-to-have, not a
substitute for the structural and content fundamentals above.

### Content shape that AI systems can actually extract and quote

- Lead with a direct, self-contained answer before elaboration — the
  same principle as the FAQ guidance above, applied to any content
  meant to answer a specific question.
- Prefer comprehensive, well-organized single pages over the same
  topic fragmented across many thin pages — fragmenting content to
  target more keywords works against both modern traditional search
  and AI extraction, which favor complete, coherent coverage.
- Don't keyword-stuff for AI systems any more than for traditional
  search — both increasingly penalize or simply ignore density tricks
  in favor of genuine relevance and clarity.
- Keep the substance in the initial HTML (see crawlability note
  above) — an AI crawler that doesn't execute JavaScript sees nothing
  useful on a client-rendered-only page.

### GEO is mostly strategic, not purely technical

The technical layer above (crawler access, structured data, content
shape) is necessary but not sufficient — a meaningful share of
whether AI systems cite a source comes down to the site's broader
authority and presence (being referenced elsewhere, having a
consistent, recognizable identity across the web) rather than any
single on-page trick. Don't expect technical changes alone to
guarantee citation; treat them as the foundation that lets genuinely
good, authoritative content actually get found and used.

## Further reading

- [Mastering generative engine optimization in 2026: Full guide](https://searchengineland.com/mastering-generative-engine-optimization-in-2026-full-guide-469142)
- [GEO, AEO, and SEO in 2026: The enterprise guide to AI visibility](https://writer.com/blog/geo-aeo-optimization/)
- [AI crawler user-agent list 2026: 14 bots and robots.txt tokens to know](https://www.anagram.ai/blog/ai-crawler-user-agent-list-2026-14-bots-and-robotstxt-tokens-to-know)
- [Robots.txt & AI Crawlers in 2026: The Full Guide](https://dataimpulse.com/blog/robots-txt-ai-crawlers/)

These move fast — re-check current guidance periodically rather than
treating this file as permanently authoritative on crawler names or
platform-specific policy details.
