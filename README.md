# Tajallius Lab Notes

This repository is a public, safety-conscious portfolio for documenting hands-on cybersecurity lab work.

The goal is to show what was designed, tested, observed, and learned without exposing information that could identify or weaken a real environment.

## Lab Focus

- Network segmentation and trust boundaries
- Firewall policy design and validation
- Wazuh setup and security monitoring
- Detection and response practice
- Security+ concepts applied in a lab

## Repository Map

- [Network segmentation overview](network-segmentation/vlan-overview.md)
- [Firewall rule notes](network-segmentation/firewall-rules.md)
- [Testing results template](network-segmentation/testing-results.md)
- [Wazuh setup notes](wazuh-siem/setup-notes.md)
- [Wazuh monitoring notes](wazuh-siem/monitoring-notes.md)
- [Security+ applied: network segmentation](security-plus-applied/network-segmentation.md)
- [Security+ applied: SIEM vs. IDS](security-plus-applied/siem-vs-ids.md)
- [Screenshot safety guide](screenshots/README.md)

## Public Documentation Rules

This repository does not publish:

- Passwords, API keys, tokens, recovery codes, or other credentials
- Public IP addresses or exact private network ranges
- MAC addresses, serial numbers, asset tags, or device identifiers
- Real hostnames, usernames, email addresses, or client information
- Unredacted logs, alerts, configuration exports, or screenshots
- Details that could enable unauthorized access

Generic labels such as `VLAN-BLUE`, `VLAN-RED`, and `VLAN-MGMT` are used in place of real network identifiers.

## Documentation Standard

Each future lab entry should record:

1. The security objective
2. The design or test method
3. The expected behavior
4. The sanitized observation
5. The lesson learned
6. The evidence reference, after a safety review

> This repository is for authorized lab work and defensive learning only.
