#!/usr/bin/env python3
"""Check workload-catalog compatibility without claiming a runtime result."""

from __future__ import annotations

import json


def main() -> int:
    try:
        import llm_serving_workloads  # noqa: F401
    except ImportError as exc:
        print(json.dumps({"status": "unavailable", "scope": "catalog-compatibility-only", "error": str(exc)}))
        return 2
    print(json.dumps({"status": "ready", "scope": "catalog-compatibility-only"}))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
