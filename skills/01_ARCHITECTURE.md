# 01 — Architecture

**Purpose:** First-read model of the Copper Finch ecosystem and its boundaries.

**Confidence note:** verified against the four README files and initial commits on 2026-11-12. The code wins (see 16).

## Current model

Copper Finch is planned as three product components: `copper-finch-api` mediates between a Supabase database API and web/Android clients; `copper-finch-web` is the front-end regulatory-compliance application; and `copper-finch-android` is the Android application. `copper-finch-specs` holds ecosystem specifications. No implementation exists yet.

## Ownership and flow

| Component | Current evidence | Present boundary |
| --- | --- | --- |
| API | `README.md` | Intended server boundary; no routes or code |
| Web | `README.md` | Intended browser client; no source or build |
| Android | `README.md` | Intended mobile client; no source or build |
| Specs | `README.md`, `git-guidelines.md` | Documentation and release policy |

The only stated flow is client → API → Supabase database API. Auth, contracts, persistence, and error handling are unverified.

## Decisions and debt

No implementation decisions or decision records exist. Highest-ranked debt: establish manifests, entry points, API contracts, data model, authentication model, test harnesses, CI, and deployment records before feature work. Miss → future documents will otherwise describe guesses as architecture.

