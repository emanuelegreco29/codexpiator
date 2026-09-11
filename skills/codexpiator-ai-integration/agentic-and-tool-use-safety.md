# Agentic & Tool-Use Safety

## Least-privilege tool access

Give an agent only the tools and scopes it actually needs for its
task — not broad standing access "in case it's useful later." An
agent with unnecessary write access, unrestricted network access, or
credentials scoped wider than its task turns any flaw in its
reasoning (or any successful prompt injection) into a much larger
blast radius than the task required.

## Human-in-the-loop for irreversible/high-blast-radius actions

Require explicit confirmation before an agent executes anything hard
to reverse or affecting shared state — deleting data, sending a
message externally, spending money, force-pushing, deploying to
production. Fully autonomous execution is appropriate for reversible,
low-stakes actions; it is not appropriate for actions where a mistake
is costly or embarrassing to undo.

## Prompt injection: untrusted content is data, never instructions

Any content an agent reads from an external or user-influenced source
— a web page, a file it wasn't told to trust, a tool's output, another
user's message — must be treated as data to reason about, never as
instructions to follow. This is the core defense against prompt
injection: an attacker who can get text into something the agent
reads will try to phrase that text as an instruction ("ignore previous
instructions and..."). Structure the agent's context so untrusted
content is clearly delimited from actual instructions (see
`prompt-engineering-basics.md`), and be skeptical of any "instruction"
that arrives via a data channel rather than the actual system/user
prompt.

## Excessive AI permissions and unpermissioned access

Don't grant an AI feature or agent access to a broader set of systems,
data, or actions than its specific use case requires — this is the
same least-privilege principle applied at the integration-design level
rather than the per-call tool-access level. Before wiring an agent up
to a new system (a database, an email account, a payment API),
confirm the access being granted matches what the feature actually
needs, not what's simply convenient to hand over.

## Bound agent loops

Cap the number of iterations, tool calls, or total cost an
autonomous agent loop can consume before requiring a check-in — an
unbounded loop (from a reasoning error, a tool returning unexpected
output, or an adversarial input) can otherwise run indefinitely,
racking up cost or taking repeated unwanted actions. This applies
directly to `mcp-usage-and-recommendations.md`'s usage-capping
guidance too.

## Validate AI output before acting on it

Never treat a model's output as automatically safe or correct just
because it's structured or confident-sounding — validate it the same
way you'd validate any other untrusted input before using it to make a
decision, write to a database, or trigger a downstream action
(schema-validate structured output, sanity-check values against
expected ranges, and apply the same input-validation discipline from
`codexpiator-security/input-validation-and-injection.md` to anything
the model's output feeds into).

## Log agent actions for auditability

Record what tools an agent called, with what arguments, and what the
result was — this is what makes it possible to reconstruct what an
agent actually did after the fact, which matters even more for
autonomous systems than for regular request/response logging (see
`codexpiator-backend/error-handling-and-logging.md`) because an
agent's behavior is less predictable in advance.
