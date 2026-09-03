# BidKV-MultiNPU evidence ledger

Source base: `dc06f417667807af69d6f1603455310f3ad4df97`.

| Asset | Evidence label | Admissible statement | Forbidden extrapolation |
| --- | --- | --- | --- |
| Accepted BidKV paper and single-device results | historical real-online, single-device NVIDIA baseline | Utility-guided victim selection is an inherited deployable local baseline. | No multi-NPU, Ascend, coordination, scaling, or topology claim. |
| `docs/BIDKV_MULTINPU_M0.md` | contract/design | Freezes the ownership/topology question, replay baselines, invariants, and stop rules. | No implementation or measured benefit. |
| `feature/bidkv-multinpu` parent/dependency branches | unreviewed development carrier | Branch identities exist for future student work. | No code or result is admitted by this paper draft. |
| Proposed deterministic replay | TBD simulation | May test whether local and global victim choices diverge after it exists and passes invariants. | Cannot be called real-online or hardware evidence. |
| Prospective matched multi-NPU run | TBD | Required for any performance/scaling claim. | No numbers or outcomes may be inferred now. |

The highest evidence for the extension is M0 design/contract. All implementation,
environment setup, NPU execution, results, and tuning remain student-owned.
