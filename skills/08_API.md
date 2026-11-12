# 08 — API

**Purpose:** Describe the public API envelope, routes, authorization, validation, versioning, and extension procedure.

**Confidence note:** verified against the API README on 2026-11-12. No endpoint, route, validator, response envelope, or version exists. The code wins (see 16).

## Current state

`copper-finch-api` is intended to communicate between Supabase and the web/Android clients. The route inventory is empty. Authentication, authorization, validation, error codes, pagination, and versioning are unverified.

## Before adding an endpoint

Define the request and response contract in specs, authorization and validation behavior, error codes, persistence effects, client impact, and tests. Add the implementation and both client integrations only after the contract is reviewed. Miss → a route can appear to work for one client while silently breaking the other.

