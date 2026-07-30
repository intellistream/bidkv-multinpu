# BidKV-MultiNPU M0 boundary

## Starting point

The inherited BidKV artifact is an accepted single-device result. Its current
code, paper, and historical result directories remain the baseline and must not
be relabeled as MultiNPU evidence.

BidKV-MultiNPU asks a separate question:

> When KV pressure is distributed across several devices, can ownership- and
> topology-aware coordination choose victims without global serialization,
> duplicated recomputation, or avoidable cross-device traffic?

The research mechanism is not simply “run BidKV with tensor parallelism.”
Multi-device execution introduces coupled ownership, asymmetric pressure,
collective dependencies, and the possibility that a locally attractive victim
is globally expensive.

## M0 deliverables

1. **Execution and ownership map**
   - Identify where request state and KV blocks are owned under the selected
     TP/DP configuration.
   - Record which decisions are local, which require coordination, and which
     runtime events make a decision stale.
   - Distinguish request-level preemption, physical block release, recomputation,
     and cross-device transfer.

2. **Deterministic replay model**
   - Model at least two devices with explicit per-device KV pressure and request
     ownership.
   - Implement independent-local BidKV, global largest-first, and an offline
     coordination oracle as baselines.
   - Include asymmetric pressure, shared requests, and a case where the local
     optimum is globally worse.

3. **Correctness and accounting invariants**
   - A request is never simultaneously treated as resident and released.
   - Freed capacity equals the blocks actually released on every owning device.
   - Recompute and transfer costs are counted once and attributed to the
     triggering decision.
   - Stale or incomplete coordination fails closed to the inherited local
     policy.

4. **Runtime integration proposal**
   - Name the exact vLLM-HUST and Ascend hook points.
   - Define the minimum coordination metadata and its update frequency.
   - Estimate control-message and synchronization cost before implementing a
     global coordinator.

## Evidence boundary

M0 is design, deterministic replay, and invariant evidence. It is not
`real-online` evidence and cannot support throughput, TTFT, or scaling claims.

Hardware experiments begin only after M0 identifies one minimal coordination
mechanism and one falsifiable benefit condition. Formal evaluation must compare:

- inherited independent/local BidKV;
- the strongest non-BidKV local baseline;
- the coordinated mechanism;
- an offline oracle when feasible.

Runs must use matched requests and configuration, at least three independent
service starts, correctness checks, raw per-run artifacts, and a manifest that
records parent/submodule revisions, devices, topology, model, runtime, graph
mode, and workload.

## Negative-stop rules

Stop or narrow the project if:

- the runtime exposes no ownership signal precise enough to avoid stale
  decisions;
- coordination cost is of the same order as the avoided recomputation;
- the coordinated policy cannot beat independent local BidKV on any
  topology-asymmetric replay case;
- the only apparent gain comes from changing effective memory, request count,
  output length, execution mode, or correctness.

## Repository and branch map

| Role | Repository path | Required branch |
|---|---|---|
| Parent artifact | `intellistream/bidkv-multinpu` | `feature/bidkv-multinpu` |
| Core runtime | `third_party/vllm-hust` | `feature/bidkv-multinpu` |
| Ascend runtime | `third_party/vllm-ascend-hust` | `feature/bidkv-multinpu` |
| Managed launcher | `third_party/vllm-hust-dev-hub` | `feature/bidkv-multinpu` |
| Shared workloads | `third_party/llm-serving-workloads` | `feature/bidkv-multinpu` |

Project-specific replay cases belong in this parent repository. Reusable
workloads belong in the workload submodule. Runtime changes must be committed
and pushed on the dedicated dependency branches before the parent updates its
submodule pointers.
