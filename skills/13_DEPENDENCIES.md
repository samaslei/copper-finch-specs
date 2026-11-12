# 13 — Dependencies

**Purpose:** Explain dependency policy, rationale, upgrade traps, and rejected alternatives.

**Confidence note:** verified against repository contents on 2026-11-12. No package manifests or dependencies exist. The code wins (see 16).

## Current policy

There is no dependency inventory or automated update configuration. Before adding one, record its purpose, supported runtime, license/security posture, version constraint, and removal or upgrade plan.

The README names Supabase as the intended backend database API, but no SDK or client library has been selected. Do not infer a package from that product name. Miss → an untracked dependency can make builds irreproducible or leak incompatible behavior into three clients.

