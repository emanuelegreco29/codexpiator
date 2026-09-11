# Prompt Engineering Basics

## Be explicit, don't hope the model infers it

State format, length, tone, and constraints directly rather than
hoping the model infers them from context — "respond in valid JSON
matching this schema" beats "give me the data," and produces far more
consistent results across runs and across slightly different inputs.

## Few-shot examples for format-sensitive tasks

When the exact output format matters (a specific JSON shape, a
particular tone, a consistent structure), include one or two concrete
examples of input-to-output in the prompt rather than only describing
the format in prose — models follow a demonstrated pattern more
reliably than a described one, especially for output structures with
several interacting rules.

## Separate instructions from untrusted data clearly

Structure prompts so the model can tell the difference between your
instructions (the system/developer-authored part) and data the prompt
is operating on (user input, fetched content) — clearly delimited,
never concatenated ambiguously. This isn't just a quality concern:
untrusted data that looks like an instruction is exactly how prompt
injection works (see `agentic-and-tool-use-safety.md`). Never treat
content from an external or user-controlled source as if it carries
the same authority as your own system instructions.

## Iterate against real test cases

Treat a prompt like code: keep a set of real example inputs (including
tricky edge cases) and check the prompt's output against them when you
change it, rather than eyeballing one or two manual tries. A prompt
change that looks like an improvement on the example you were staring
at can regress a case you didn't happen to re-check.

## Version-control prompts

Keep prompts in source control alongside the code that uses them, not
hardcoded as a string with no history — a prompt is logic, and it
should be reviewable, diffable, and revertible the same way any other
logic change is.
