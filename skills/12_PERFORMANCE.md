# 12 — Performance

**Purpose:** Record limits, hot paths, expensive operations, and profiling methods.

**Confidence note:** verified against the current trees on 2026-11-12. No executable code or performance evidence exists. The code wins (see 16).

## Current state

There are no measured limits, hot paths, deliberate inefficiencies, load tests, or profilers. Do not set latency or throughput targets without a product requirement and measurement.

## When implementation arrives

Measure API/database round trips, client startup and rendering, Android network/offline behavior, and bundle size. Record workload, device/environment, baseline, and command. Miss → optimizing an unmeasured path can add complexity while leaving the actual bottleneck unchanged.

