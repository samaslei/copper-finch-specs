# 10 — Deployment

**Purpose:** Explain release order, deployables, candidate tags, and production approval.

**Confidence note:** release policy verified in `../git-guidelines.md` on 2026-11-12; deploy commands and infrastructure are absent. The code wins (see 16).

## Release policy

Development follows `main → beta → release → production`. Developers unit-test on `main`; QA system-tests `beta`; independent testers test only a published bundle from `release`; a designated approver separately approves production. Corrections must be carried back upstream through a reviewed merge or cherry-pick.

Product prefixes are `WCN` web, `BCN` API, `ACN` Android, and `SCN` specs. The next first tags are `WCN.01.0.001`, `BCN.01.0.001`, `ACN.01.0.001`, and `SCN.01.0.001`. No tags exist. Never tag the current week before local Friday 5:00 PM, and never move or reuse a tag.

## Missing checklist items

Build commands, environment variables, deployment targets, release website, component order, health checks, rollback, and approvals are not yet specified. Miss → a tag may identify code that was never published or approved.

