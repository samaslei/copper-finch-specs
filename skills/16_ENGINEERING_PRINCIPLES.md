# 16 — Engineering Principles

**Purpose:** Capture short, evidence-backed rules that guide future work.

**Confidence note:** verified against the handoff, git guidelines, and four initial commits on 2026-11-12. The code wins (see 16).

1. **Document only what the code and evidence support.** The repositories contain only READMEs, so architecture, security, and test claims beyond them are unverified. Miss → newcomers build on invented behavior.
2. **Keep ecosystem contracts lockstep.** API, web, Android, database, and specs must change together when a shared contract changes. Miss → one client silently diverges.
3. **Promote through gates in order.** `main → beta → release → production` is a controlled path, and production approval is separate. Miss → unreleased or unapproved code reaches independent testers or users.
4. **Tag the artifact that was actually tested.** Tags identify the exact published commit, and tags are never moved or reused. Miss → a release label cannot reproduce the tested build.
5. **Record why beside the rule.** A name without the failure it prevents is not durable handoff knowledge. Miss → a future cleanup removes a guard whose incident is forgotten.

Trust the code over any document, including this one.

