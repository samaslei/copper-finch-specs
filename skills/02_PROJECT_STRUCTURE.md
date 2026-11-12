# 02 — Project Structure

**Purpose:** Explain where code and documentation belong while the repositories are being bootstrapped.

**Confidence note:** verified against the repository trees and READMEs on 2026-11-12. The code wins (see 16).

## Current tree

At the ecosystem root: `AGENTS.md`, `handoff.md`, and four sibling repositories. Each repository currently contains `README.md`, its own `.git`, and (in the working tree) an untracked `AGENTS.md`; the specs repository also contains `git-guidelines.md` and this `skills/` directory.

## Placement rules

- Put API implementation, tests, and configuration in `copper-finch-api`; do not place server code in specs.
- Put browser implementation in `copper-finch-web`; do not place it in the API repository.
- Put Android implementation in `copper-finch-android`.
- Put cross-component contracts and engineering knowledge in `copper-finch-specs`; skills use `NN_TOPIC.md` names.
- Add a manifest before adding source so the build and runtime entry point are explicit.

Naming conventions beyond repository names are not yet evidenced. Miss → inventing package, route, or module names now would create false coupling.

