# Network Segmentation Foundations

> **Status: Reference.** This note explains design principles and review questions. It does not describe a deployed network.

Network segmentation separates systems into controlled trust zones so access can be limited, monitored, and reviewed.

## Core Principles

- **Least privilege:** Each zone receives only the access required for its role.
- **Implicit deny:** Cross-zone traffic is blocked unless a documented rule permits it.
- **Defense in depth:** Segmentation complements endpoint, identity, monitoring, and administration controls.
- **Attack-surface reduction:** A compromised system has fewer reachable targets.
- **Logging and accountability:** Important allowed and denied flows create useful events.
- **Change control:** Temporary exceptions have a purpose, owner, expiration condition, and review path.

## Reference Zone Model

| Security purpose | Generic zone label | Intended boundary |
|---|---|---|
| Restricted administration | `VLAN-MGMT` | Initiates only approved management connections |
| Defensive services | `VLAN-BLUE` | Receives approved administration and sends security telemetry |
| Authorized exercises | `VLAN-RED` | Reaches only explicitly scoped test targets |
| Centralized monitoring | `VLAN-LOGS` | Receives approved telemetry without broad lateral access |
| Isolated test workload | `VLAN-GUEST` | Receives only temporary, documented exercise traffic |

## Review Questions

- Is traffic denied when no rule explicitly permits it?
- Can administrative services be reached only from the management zone?
- Does each rule identify a business or testing purpose?
- Are temporary exceptions easy to identify, expire, and remove?
- Do important denies create useful monitoring events?
- Can an observed deny be corroborated in the enforcement device's logs?

## Practice Exercise

1. Define the source zone and destination service using generic labels.
2. Record the expected allow or deny result.
3. Run a bounded check only in an authorized lab.
4. Correlate the transport result with the enforcement-device event.
5. Sanitize the observation before publication.
6. Record limitations, including cases where a failed connection is not enough to prove a policy deny.
