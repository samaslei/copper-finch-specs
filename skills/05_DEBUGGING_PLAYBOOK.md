# 05 — Debugging Playbook

**Purpose:** Provide symptom-first diagnostics and the commands used to investigate failures.

**Confidence note:** verified against the current trees on 2026-11-12. No runtime logs or error messages exist. The code wins (see 16).

## First checks

1. Run `git status --short --branch` in the affected repository.
2. Confirm the change is in the correct sibling repository.
3. Inspect the repository README and the latest commit with `git show --stat`.
4. Search for the exact message with `rg -n "<message>" .`.

## Known symptoms

None are known. There is no application to run, log directory, test command, or error catalog. Do not invent a likely cause from the empty scaffold.

Miss → treating “no implementation” as a runtime failure wastes time; first establish the missing manifest or entry point and record it in `INBOX.md`.

