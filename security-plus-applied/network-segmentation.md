# Security+ Applied: Network Segmentation

Network segmentation divides systems into controlled trust zones so that access can be limited, monitored, and tested.

## Concepts Applied

- **Least privilege:** Each zone receives only the access needed for its role.
- **Implicit deny:** Unapproved cross-zone traffic is blocked.
- **Defense in depth:** Segmentation works with endpoint controls, monitoring, and secure administration.
- **Attack-surface reduction:** A compromised test system has fewer reachable targets.
- **Logging and accountability:** Important allowed and denied flows produce reviewable events.
- **Change control:** Temporary exceptions have a purpose, owner, and removal condition.

## Lab Mapping

| Security concept | Generic lab example |
|---|---|
| Trust boundary | Separation between `VLAN-RED` and `VLAN-MGMT` |
| Administrative plane | Restricted management through `VLAN-MGMT` |
| Monitoring zone | Defensive services in `VLAN-BLUE` |
| Controlled test target | Temporary workload in `VLAN-TEST` |
| Compensating control | Alerting on a narrowly approved temporary flow |

## Validation Questions

- Is traffic denied when no rule explicitly permits it?
- Can administrative services be reached only from the management zone?
- Are temporary exceptions easy to identify and remove?
- Do important denies create useful monitoring events?
- Can the same test be repeated without relying on sensitive identifiers?

## Lesson Template

- **Concept:**
- **What was built:**
- **What was tested:**
- **What the evidence showed:**
- **What would be improved next:**
