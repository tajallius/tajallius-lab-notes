# Segmentation Validation Case Study (Reconstructed)

> **Evidence status:** Reconstructed methodology. This entry documents a test design and reporting approach; it does not contain measured network results. See the [evidence matrix](../EVIDENCE.md).

## Objective

Evaluate whether a segmented lab would enforce these intended trust boundaries:

- Administrative access originates only from `VLAN-MGMT`.
- Defensive systems in `VLAN-BLUE` can send telemetry to `VLAN-LOGS`.
- `VLAN-RED` can reach only an approved exercise target in `VLAN-GUEST`.
- Denied cross-zone attempts create useful gateway events.

## Reference Zone Model

| Source zone | Intended access |
|---|---|
| `VLAN-MGMT` | Approved administrative services in `VLAN-BLUE` |
| `VLAN-BLUE` | Approved telemetry services in `VLAN-LOGS` |
| `VLAN-RED` | Approved exercise services in `VLAN-GUEST` only |
| `VLAN-LOGS` | Receives security telemetry without broad lateral access |
| `VLAN-GUEST` | Isolated exercise workload |

No VLAN numbers, addresses, hostnames, or device identifiers are published.

## Test Method

The companion [`segmentation-validation.sh`](../artifacts/segmentation-validation.sh) requires the operator to supply one declared source zone, authorized target, destination label, protocol, port, and expected result. It sends no traffic in its default plan mode and requires both `--execute` and `--authorized` before probing.

Run each check from the stated source zone. The script cannot confirm the host's actual zone membership.

## Test Cases

| Test ID | Source | Destination | Expected | Evidence needed | Public status |
|---|---|---|---|---|---|
| `SEG-001` | `VLAN-MGMT` | `VLAN-BLUE` administration | Allow | Successful bounded connection and matching gateway event | Not run |
| `SEG-002` | `VLAN-BLUE` | `VLAN-LOGS` telemetry | Allow | Successful listener check and ingestion evidence | Not run |
| `SEG-003` | `VLAN-RED` | `VLAN-MGMT` administration | Deny | Failed connection and matching gateway deny event | Not run |
| `SEG-004` | `VLAN-RED` | `VLAN-GUEST` exercise service | Temporary allow | Approved change, successful check, and expiration review | Not run |
| `SEG-005` | `VLAN-GUEST` | `VLAN-MGMT` administration | Deny | Failed connection and matching gateway deny event | Not run |

## Observation Template

Record the following privately during an authorized run, then publish only a sanitized summary:

```text
Test ID:
Execution date:
Tool and version:
Declared source zone:
Destination label:
Expected result:
Observed transport result:
Gateway rule and action:
Timestamp correlation:
Conclusion:
Limitations:
```

## Analysis and Tuning Questions

- Did the transport result match the intended policy?
- Does the gateway event identify the expected rule and action?
- Are successful administrative sessions logged at a useful level?
- Should isolated denies remain informational while repeated attempts escalate?
- Does every temporary allow rule have an owner and removal condition?

## Limitation

A failed connection does not prove that a firewall rule caused the failure; routing, name resolution, or service availability can produce the same result. A credible deny finding requires corroborating enforcement-device evidence.

## Next Step

Run these cases in an authorized environment, retain original evidence privately, and replace each `Not run` status only with a sanitized measured observation.
