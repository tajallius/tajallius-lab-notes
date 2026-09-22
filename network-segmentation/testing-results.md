# Segmentation Validation: Reconstructed Lab Exercise

> **Evidence status:** Completed reconstruction using invented lab data and documentation-only identifiers. This demonstrates the testing and reporting method; it is not a capture from a live network.

## Objective

Validate that the fictional lab design enforces its intended trust boundaries:

- Administrative access originates only from `DEMO-MGMT`.
- Defensive systems in `DEMO-BLUE` can send telemetry to `DEMO-LOGS`.
- `DEMO-RED` can reach only the temporary exercise target in `DEMO-GUEST`.
- Denied cross-zone attempts create useful monitoring events.

## Reconstructed Topology

| Zone | Example source | Intended access |
|---|---|---|
| `DEMO-MGMT` | `10.77.10.20` | Administrative services in `DEMO-BLUE` |
| `DEMO-BLUE` | `10.77.20.15` | Telemetry service in `DEMO-LOGS` |
| `DEMO-RED` | `10.77.30.25` | Authorized target in `DEMO-GUEST` only |
| `DEMO-LOGS` | `10.77.40.10` | Receives approved security telemetry |
| `DEMO-GUEST` | `10.77.50.20` | Isolated exercise target |

All addresses are invented RFC 1918 examples. Asset names and identifiers do not correspond to real equipment.

## Test Method

The companion script [`artifacts/segmentation-validation.sh`](../artifacts/segmentation-validation.sh) documents the commands used for each reachability check. It runs only when the operator supplies `--execute`; its default mode prints the plan without sending traffic.

The reconstructed evidence below assumes the following authorized checks:

```text
curl --connect-timeout 3 --head https://10.77.20.15/
nc -zvw3 10.77.40.10 1514
nc -zvw3 10.77.10.10 22
nc -zvw3 10.77.50.20 443
```

## Completed Results

| Test ID | Source | Destination | Expected | Reconstructed observation | Status |
|---|---|---|---|---|---|
| `SEG-001` | `DEMO-MGMT` | `DEMO-BLUE` secure web service | Allow | Connection completed and returned a successful HTTP response header | Pass |
| `SEG-002` | `DEMO-BLUE` | `DEMO-LOGS` telemetry service | Allow | TCP session to the example telemetry listener completed | Pass |
| `SEG-003` | `DEMO-RED` | `DEMO-MGMT` administrative service | Deny and log | Connection timed out; gateway event recorded rule `LAB-SEG-0042` with action `block` | Pass |
| `SEG-004` | `DEMO-RED` | `DEMO-GUEST` exercise service | Allow temporarily | Connection completed during the fictional exercise window | Pass |
| `SEG-005` | `DEMO-GUEST` | `DEMO-MGMT` administrative service | Deny and alert | Connection timed out; repeated attempts produced a high-severity monitoring event | Pass |

## Sanitized Gateway Event

```json
{
  "event_time": "2026-04-26T14:36:12Z",
  "device": "demo-fw-01",
  "rule": "LAB-SEG-0042",
  "source_zone": "DEMO-RED",
  "source_ip": "10.77.30.25",
  "destination_zone": "DEMO-MGMT",
  "destination_ip": "10.77.10.10",
  "service": "ssh",
  "action": "block",
  "note": "Invented event for a reconstructed lab exercise"
}
```

## Finding

The policy behaved as designed in the reconstructed dataset, but the first draft logged every isolated deny at high severity. That would create unnecessary analyst noise during normal scanning and misconfiguration.

## Tuning Decision

- Keep single denied cross-zone attempts at informational severity.
- Raise severity only after repeated attempts from the same source within a short window.
- Preserve high severity for any attempted access from `DEMO-RED` or `DEMO-GUEST` to `DEMO-MGMT`.
- Add the exercise identifier to temporary allow rules so approved testing can be separated from unexpected activity.

## Validation Outcome

The reconstructed test demonstrates a repeatable process: define the boundary, state the expected result, run a bounded check, collect the corresponding gateway event, compare behavior with policy, and document the tuning decision.

## Limitations and Next Step

These are invented observations, not measured results. The next credible milestone is to run the same script on an authorized lab, replace the reconstructed observations with actual sanitized output, and retain the original evidence privately.
