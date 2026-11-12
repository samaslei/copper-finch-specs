# 07 — Database

**Purpose:** Document identity, integrity, deletion, migrations, and indexing rules for persisted data.

**Confidence note:** the API README mentions a Supabase database API, but no schema, migration, query, constraint, or configuration exists; verified 2026-11-12. The code wins (see 16).

## Current evidence

The intended database boundary is Supabase, mediated by `copper-finch-api`. Identity strategy, tables, keys, constraints, delete behavior, indexes, migrations, and RLS are unknown.

## Required before data work

Define the schema and migration tool, name primary and foreign keys, specify delete semantics and RLS, and add integrity and migration tests. Record dangerous operations and rollback steps. Miss → clients may depend on undocumented columns or a migration may destroy data without a recoverable path.

