# 09 — Security

**Purpose:** Record the threat model, trust boundaries, authentication, authorization, secret handling, and security checks.

**Confidence note:** verified against the current repositories on 2026-11-12. No security implementation or configuration exists. The code wins (see 16).

## Known boundary

Web and Android clients are untrusted callers of the API; the API is the stated mediator to Supabase. This is an inferred boundary from the READMEs, not an implemented control.

## Missing controls

Authentication, authorization, RLS, input validation, injection defenses, transport requirements, debug gates, secret storage, audit logging, and dependency scanning are all unverified. Name environment variables in documentation, never their values. Add a security checklist before exposing an endpoint.

Miss → putting a Supabase credential in either client would expose the database boundary; the actual safe key model must be defined before implementation.

