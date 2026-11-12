# 03 — Code Style

**Purpose:** Record verified coding, error-handling, logging, tooling, and commit conventions.

**Confidence note:** verified against the initial repository contents and `git-guidelines.md` on 2026-11-12. The code wins (see 16).

## Current rules

No source code, formatter, linter, logger, error type, or language configuration exists. Add those rules only after the relevant implementation and tool configuration land.

Commit messages must begin with a lowercase product or general scope, an imperative sentence-case summary, and no period; the summary is limited to 50 characters. Example: `code-name-specs/design: Add spacing tokens`. For non-trivial changes, explain why in a body. No AI agent may be added as author of commits, tags, releases, or PRs.

Use the most specific scope: `code-name-api/<feature>`, `code-name-web/<feature>`, `code-name-app/<feature>`, or `code-name-specs/<feature>`.

Miss → a generic `api:` or past-tense summary violates the repository’s commit policy and makes history harder to search.

