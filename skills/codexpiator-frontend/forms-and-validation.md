# Forms & Validation

## Client-side validation is UX, not security

Client-side checks exist to give the user fast, friendly feedback —
they do not protect your backend. Always re-validate (and re-check
authorization) on the server for every field a client claims to have
validated. A client can be bypassed entirely (direct API calls,
modified requests), so any validation that only exists client-side is
not enforced at all from a security standpoint.

## Controlled vs uncontrolled inputs

Controlled inputs (the framework's state is the single source of
truth for the field's value) give you full control over formatting,
conditional logic, and validation-as-you-type, at the cost of a
re-render per keystroke. Uncontrolled inputs (the DOM holds the value;
you read it on submit or via a ref) avoid that re-render cost and are
simpler for large forms with little cross-field logic. Prefer
uncontrolled for large, simple forms without live cross-field
validation; prefer controlled when you need to react to every
keystroke (live formatting, live validation, conditional fields).

## Schema-based validation

Define the validation rules once, as a schema, and use it for both the
client-side hint and the server-side enforcement wherever your stack
allows sharing it (e.g. a schema library usable on both ends in a
JS/TS full-stack app). This avoids the two sides drifting out of sync
— a common bug where the client accepts something the server silently
rejects, or vice versa, because the rules were hand-written twice.

## Error message placement and timing

- **Timing:** validate on blur for the first pass (don't show an error
  while the user is still mid-typing their first attempt at a field);
  after the first error has been shown for a field, switch to live
  (on-change) validation for that field so the error clears as soon as
  it's fixed. Validate everything again on submit regardless, since a
  user can submit without touching every field.
- **Placement:** put the error message immediately next to the field
  it describes, not only in a summary block at the top of the form —
  a summary-only approach forces the user to hunt for which field is
  wrong.

## Accessible error association

Associate an error message with its field programmatically
(`aria-describedby` pointing at the error's id, `aria-invalid="true"`
on the field while it's in an error state) so assistive technology
announces the error when the field receives focus — not just visually
adjacent text with no programmatic link.
