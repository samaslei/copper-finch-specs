# 11 — Testing

**Purpose:** State how confidence is gained and what must be tested at each release gate.

**Confidence note:** verified against the four initial repositories and release policy on 2026-11-12. No test framework or test exists. The code wins (see 16).

## Current confidence

There is no measurable coverage. The only available check is repository inspection and `git` metadata.

## Required test layers

- Developers: unit tests on `main` once units exist.
- QA: system tests of major product claims on `beta`.
- Independent testers: integration tests of the published `release` bundle only.
- Final approver: verify the exact approved release candidate is deployed.

Add tests for API contracts, client behavior, database invariants, authorization, migration rollback, offline/mobile behavior, and failure paths when those features are implemented. Miss → an empty test report can be mistaken for a passing test suite.

