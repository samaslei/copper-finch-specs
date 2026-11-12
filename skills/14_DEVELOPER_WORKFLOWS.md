# 14 — Developer Workflows

**Purpose:** Give repeatable recipes for setup, changes, testing, and release.

**Confidence note:** verified against the current repositories and git guidelines on 2026-11-12. No build or test commands exist. The code wins (see 16).

## Inspect the current baseline

1. Enter the relevant repository.
2. Run `git status --short --branch`.
3. Read its `README.md` and `AGENTS.md`.
4. Run `git log --oneline --decorate -10` and inspect the changed files.

## Add the first implementation

1. Define the contract in specs.
2. Add the component manifest and entry point.
3. Add tests and CI before depending on the new behavior.
4. Update 02, 04, 08, 09, and 11 with verified paths and commands.
5. Commit with the required product scope and imperative summary.

## Release

Promote reviewed code through `main`, `beta`, and `release`; publish the bundle; use `a`, `b`, and `rc` candidate labels; obtain separate production approval; deploy the exact approved candidate. Follow `../git-guidelines.md` for weekly tags.

Add what surprised you to `INBOX.md`.

