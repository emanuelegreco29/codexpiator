# State Management

## The decision tree

1. **Can it be derived from other state or props?** Don't store it —
   compute it at render time. Storing what can be computed is the
   single most common source of state-sync bugs (two copies of the
   same fact drifting apart).
2. **Is it needed by exactly one component?** Keep it local
   (component-level state). Don't lift it "just in case" — lift it
   when a second component actually needs it.
3. **Is it needed by a few nearby components?** Lift it to their
   nearest common ancestor and pass it down. Don't reach for a global
   store for a concern that three sibling components share.
4. **Is it needed broadly across the app, or does it persist across
   navigations?** That's when a global mechanism (context, a client
   store) earns its cost.
5. **Did it come from the server?** It's server state, not client
   state — see below. Don't put it in the same bucket as UI-only
   state.

## Server state vs client state

Server state (data fetched from an API) has different needs than
client state (UI-only concerns like "is this dropdown open"): it can
go stale, it can fail to load, it can be refetched, and multiple
components may want the same piece of it without re-fetching. Treat
it as a cache, not as regular application state — a dedicated
data-fetching/cache layer (the pattern popularized by libraries like
React Query/SWR, framework-agnostic in concept) handles staleness,
deduplication, and refetching far better than hand-rolling it with a
general-purpose state store.

Client-only state (form input before submit, a modal's open/closed
state, a selected tab) is what a general state store or local
component state is for. Mixing the two — putting fetched data into
the same store as UI toggles — tends to produce a store that's
responsible for too much and hard to reason about.

## When a full state library is overkill

Most CRUD-shaped apps need: a server-state cache layer, plus local
component state for UI concerns, plus maybe one small shared store for
a handful of genuinely cross-cutting values (current user, theme,
feature flags). That's often enough — reaching for a heavyweight
global store to hold everything, including data that's really server
state, adds indirection without solving a problem you actually have.
Introduce a bigger state-management solution when you have a concrete
symptom (prop-drilling pain across many components, genuinely
app-wide state with complex update logic), not preemptively.

## The derived-state anti-pattern, explicitly

```
// Anti-pattern: storing a fact that's really a computation
[fullName, setFullName] = useState('')
useEffect(() => setFullName(`${firstName} ${lastName}`), [firstName, lastName])

// Better: compute it
const fullName = `${firstName} ${lastName}`
```

The anti-pattern version can drift (an update to `firstName` without
the effect running yet) and adds an unnecessary render cycle. If you
find yourself synchronizing one piece of state from another with an
effect, that's almost always a sign the second value should be
computed, not stored.

See `shared/stack-recommendations.md` for React/Vue-specific notes on
where server-state caching and reactivity idioms live in each
framework.
