# 04 — Change Rules

**Purpose:** Track lockstep sets whose members must change together.

**Confidence note:** verified against all tracked files on 2026-11-12. No implementation lockstep sets exist yet. The code wins (see 16).

## Inventory

1. No constants, enums, registries, column lists, error codes, mirrored types, routes, or generated artifacts are present.
2. The ecosystem has four names and release prefixes (`WCN`, `BCN`, `ACN`, `SCN`) defined in `copper-finch-specs/git-guidelines.md`; update the release guidance and this inventory together if they change.

## Safe change procedure

1. Search all four repositories for the symbol or contract before editing.
2. Identify every producer and consumer.
3. Change the contract and all consumers in one reviewed change.
4. Run the tests and build commands once they exist; record them here.

Miss → changing an API field, database column, or generated client in only one repository will silently break a consumer. High-risk areas cannot yet be ranked because they do not exist.

