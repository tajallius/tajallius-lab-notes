# Firewall Rules

This file records the intent and validation method for generic lab firewall policies. It is not a copy of a live ruleset.

## Policy Baseline

- Default deny between lab zones
- Explicit allow rules for required services
- Administrative access limited to `VLAN-MGMT`
- Logging enabled for relevant denies and high-value allows
- Temporary rules labeled, reviewed, and removed after the exercise
- No direct path from an untrusted lab zone to personal or production systems

## Example Policy Matrix

| Source | Destination | Service category | Action | Reason |
|---|---|---|---|---|
| `VLAN-MGMT` | `VLAN-BLUE` | Approved administration | Allow | Maintain defensive services |
| `VLAN-BLUE` | Approved update service | Secure web access | Allow | Retrieve trusted updates |
| `VLAN-RED` | `VLAN-TEST` | Exercise-specific traffic | Allow temporarily | Conduct an authorized test |
| `VLAN-RED` | `VLAN-MGMT` | Any | Deny and log | Protect the management boundary |
| Any lab zone | Unapproved destination | Any | Deny and log | Enforce least privilege |

## Rule Review Template

- **Rule purpose:**
- **Business or lab need:**
- **Source zone:**
- **Destination zone:**
- **Service category:**
- **Expected duration:**
- **Logging requirement:**
- **Validation method:**
- **Rollback condition:**
- **Reviewer:**

## Safe Publishing Notes

Describe rule intent rather than exporting a live configuration. Remove addresses, interface names, usernames, device names, unique object names, and internal comments before sharing.
