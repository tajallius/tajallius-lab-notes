# VLAN Overview

This document describes a generic segmented lab design. It intentionally omits addresses, device names, hardware details, and production configuration.

## Example Zones

| Generic label | Purpose | Typical trust level |
|---|---|---|
| `VLAN-MGMT` | Administrative access to lab services | Restricted |
| `VLAN-BLUE` | Defensive monitoring and analysis systems | Trusted lab zone |
| `VLAN-RED` | Isolated offensive-security practice systems | Untrusted lab zone |
| `VLAN-TEST` | Temporary validation workloads | Limited |

These labels are documentation aliases, not exact network identifiers.

## Design Principles

- Separate administrative, defensive, offensive, and test activity.
- Deny cross-zone traffic by default.
- Allow only the minimum services needed for a documented exercise.
- Send relevant security events to the monitoring platform.
- Review temporary exceptions and remove them after testing.
- Keep lab activity isolated from personal, client, and production systems.

## Simplified Flow

```text
Authorized administrator
        |
    VLAN-MGMT
        |
   approved access
        |
VLAN-BLUE ---- monitored lab services
        |
  explicitly allowed test flow
        |
    VLAN-RED / VLAN-TEST
```

## Evidence to Add Later

Safe evidence may include:

- A redrawn diagram using only the generic labels above
- A short explanation of each trust boundary
- Sanitized test outcomes
- A summary of one rule change and its defensive purpose

Before publishing evidence, follow the checklist in [screenshots/README.md](../screenshots/README.md).
