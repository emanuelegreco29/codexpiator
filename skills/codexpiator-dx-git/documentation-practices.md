# Documentation Practices

## A README that answers three questions

At minimum, a project's README should let a new person answer: **what
is this** (a sentence or two on purpose), **how do I run it** (setup
and run instructions that actually work from a clean checkout), and
**how do I contribute** (where tests live, how to submit a change).
Anything beyond that is a bonus; missing one of these three is a real
onboarding gap.

## Comments explain why, not what

The code already says *what* it does to anyone who reads it; a comment
that just restates that in English adds noise, not information. Write
a comment when there's a *why* that isn't visible in the code itself —
a non-obvious constraint, a workaround for a specific bug or external
limitation, a reason a seemingly-simpler approach wasn't used.

## Architecture decision records for consequential choices

For a decision that's hard to reverse and shaped the system
meaningfully (choosing a database, choosing a service boundary,
picking an auth strategy), write a short ADR: the context, the options
considered, the choice made, and why. This saves a future maintainer
from re-litigating a decision without knowing what was already
considered and ruled out.

## Keep docs next to the code they describe

Documentation colocated with the code it documents (a module's own
README, comments in the relevant file) is far more likely to get
updated when that code changes than documentation living in a separate
wiki or docs site disconnected from the change process. Prefer
colocation wherever the tooling allows it.

## Avoid documentation that just restates the code

A doc comment that mechanically repeats a function's signature in
prose ("getUser(id): gets the user with the given id") will rot the
moment the function's actual behavior gets more nuanced, and until
then it's telling the reader nothing they couldn't see themselves.
Document behavior, constraints, and intent — not the parts already
obvious from reading the code.
