# LLM Integration Patterns

## Stream for perceived latency

Stream tokens to the client as they're generated rather than waiting
for the full response — an LLM call can take several seconds, and a
streaming response feels responsive from the first token while an
equivalent non-streaming call feels frozen for the same total
duration.

## Structured output over free-text-then-parse

When the result needs to be consumed programmatically (populating a
form, driving a UI decision, feeding another system), use
schema-constrained/structured output (JSON mode, function-calling-
style structured responses) rather than asking for free text and
regex-parsing it afterward. Free-text parsing is fragile against
model output drift; structured output makes the contract explicit and
enforced.

## RAG before fine-tuning

When "the model doesn't know our data" is the problem, retrieval-
augmented generation (fetch relevant context at query time and include
it in the prompt) is almost always the right first answer — cheaper,
faster to iterate, and easier to keep current than fine-tuning, which
requires retraining to reflect new data. Reserve fine-tuning for
cases where the actual need is a different response *style/format*
consistently, not "the model needs more facts."

## Cache identical/near-identical prompts

For prompts that repeat (the same question, the same system prompt
prefix across many calls), cache the result or make use of provider-
level prompt caching where available — this reduces both latency and
cost for repeated or highly-similar requests.

## Graceful degradation on provider failure

An LLM call can time out, error, or return something malformed just
like any other external dependency (see
`codexpiator-backend/resilience-and-rate-limiting.md`) — never leave
the user with a silent hang. Have an explicit fallback: a clear error
message, a retry with backoff, or a degraded non-AI path if one makes
sense for the feature.
