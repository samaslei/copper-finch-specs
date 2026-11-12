# 15 — Known Limitations

**Purpose:** Rank gaps likely to surprise contributors and distinguish facts from assumptions.

**Confidence note:** verified against all available files and commits on 2026-11-12. The code wins (see 16).

## Ranked gaps

1. **Very high:** no implementation, manifests, entry points, or tests exist.
2. **Very high:** database schema, API contract, authentication, authorization, and secret handling are unspecified.
3. **High:** no CI, deployment target, release website, health check, or rollback procedure exists.
4. **High:** no dependency inventory, supported runtime matrix, or performance budget exists.
5. **Medium:** the four repositories are separate git repositories with no documented promotion automation.

These are gaps, not bugs. The Supabase mediation and web regulatory-compliance purpose are verified from READMEs; all deeper architecture is inferred or suspect until code and requirements establish it.

