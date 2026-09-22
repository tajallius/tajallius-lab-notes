# Synthetic Lab Environment

> **Fictional demonstration only.** Every name, address, identifier, credential, event, and result on this page was invented for portfolio use. Nothing here identifies or authenticates to a real system.

This example turns the repository templates into a concrete lab story while keeping real infrastructure private.

## VLAN and Address Plan

| VLAN | Label | Fictional subnet | Example gateway | Purpose |
|---|---|---|---|---|
| 110 | `DEMO-MGMT` | `10.77.10.0/24` | `10.77.10.1` | Restricted administration |
| 120 | `DEMO-BLUE` | `10.77.20.0/24` | `10.77.20.1` | Defensive tools and analyst systems |
| 130 | `DEMO-RED` | `10.77.30.0/24` | `10.77.30.1` | Authorized offensive-security exercises |
| 140 | `DEMO-LOGS` | `10.77.40.0/24` | `10.77.40.1` | Centralized logging and monitoring |
| 150 | `DEMO-GUEST` | `10.77.50.0/24` | `10.77.50.1` | Untrusted test clients |

The example public endpoint `192.0.2.25` comes from the documentation-only range `192.0.2.0/24`. The example IPv6 prefix is `2001:db8:77::/64`, which is also reserved for documentation.

## Fictional Assets

| Asset | Role | Address | Demo MAC | Demo serial |
|---|---|---|---|---|
| `demo-fw-01` | Segmentation gateway | `10.77.10.1` | `02:00:00:77:10:01` | `DEMO-FW-0001` |
| `demo-blue-01` | Analyst workstation | `10.77.20.15` | `02:00:00:77:20:15` | `DEMO-WS-0015` |
| `demo-red-01` | Exercise workstation | `10.77.30.25` | `02:00:00:77:30:25` | `DEMO-WS-0025` |
| `demo-siem-01` | Monitoring platform | `10.77.40.10` | `02:00:00:77:40:10` | `DEMO-SIEM-0010` |
| `demo-guest-01` | Untrusted test client | `10.77.50.20` | `02:00:00:77:50:20` | `DEMO-GUEST-0020` |

The MAC addresses use the locally administered `02` prefix and are fictional.

## Nonfunctional Demo Credentials

These values are labels for screenshots and documentation. They are deliberately unusable.

| Field | Demonstration value |
|---|---|
| Portal | `https://siem.demo.invalid` |
| Analyst username | `demo-analyst` |
| Administrator username | `demo-admin` |
| Password marker | `DEMO-ONLY-NOT-A-REAL-PASSWORD` |
| API token marker | `EXAMPLE_TOKEN_NOT_VALID` |

The `.invalid` domain is reserved and cannot be a real public service. No real password, token, key, or certificate is stored in this repository.

## Example Firewall Policy

| Source | Destination | Service | Action | Monitoring expectation |
|---|---|---|---|---|
| `DEMO-MGMT` | `DEMO-BLUE` | Approved administration | Allow | Record successful administrative session |
| `DEMO-BLUE` | `DEMO-LOGS` | Security telemetry | Allow | Confirm events reach the SIEM |
| `DEMO-RED` | `DEMO-LOGS` | Direct access | Deny | Raise a boundary violation alert |
| `DEMO-RED` | `DEMO-GUEST` | Exercise traffic | Allow temporarily | Tag events with the exercise ID |
| `DEMO-GUEST` | `DEMO-MGMT` | Any | Deny and log | Escalate repeated attempts |
| Any demo zone | Unapproved destination | Any | Deny and log | Review for misconfiguration or misuse |

## Synthetic Test Results

| Test | Expected | Invented observation | Status |
|---|---|---|---|
| `DEMO-RED` requests management access | Denied and logged | Gateway denied the flow; SIEM received a high-severity event | Pass |
| `DEMO-BLUE` sends telemetry to `DEMO-LOGS` | Allowed | Events appeared in the dashboard within the fictional test window | Pass |
| `DEMO-GUEST` requests an unapproved destination | Denied | Deny event recorded with the generic asset label | Pass |
| Monitoring agent is paused on `demo-blue-01` | Visibility gap detected | Dashboard changed the agent state to disconnected | Pass |

These results are examples of how real, authorized observations could be documented. They are not claims about a deployed environment.

## Synthetic Monitoring Screenshot

![Synthetic SIEM dashboard showing invented alerts and assets](../screenshots/synthetic-siem-dashboard.png)

This portfolio mockup uses invented event data and is not a capture from a live monitoring platform.

## What This Demonstrates

- A clear trust-zone design
- Least-privilege firewall intent
- Safe handling of credentials and identifiers
- SIEM-oriented validation and alert review
- A repeatable documentation format for future authorized lab work

## Completed Reconstructed Exercises

- [Segmentation validation](../network-segmentation/testing-results.md)
- [Wazuh alert investigation and tuning](../wazuh-siem/monitoring-notes.md)
- [Reusable technical artifacts](../artifacts/README.md)
