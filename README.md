# Tajallius Lab Notes

This repository is a public, safety-conscious portfolio for documenting hands-on cybersecurity lab work.

The goal is to show what was designed, tested, observed, and learned without exposing information that could identify or weaken a real environment.

## Lab Focus

- Network segmentation and trust boundaries
- Firewall policy design and validation
- Wazuh setup and security monitoring
- Detection and response practice
- Security+ concepts applied in a lab
- A fully synthetic example environment with safe evidence

## Repository Map

- [Completed reconstructed segmentation validation](network-segmentation/testing-results.md)
- [Completed reconstructed Wazuh investigation](wazuh-siem/monitoring-notes.md)
- [Reusable technical artifacts](artifacts/README.md)
- [Network segmentation overview](network-segmentation/vlan-overview.md)
- [Firewall rule notes](network-segmentation/firewall-rules.md)
- [Wazuh setup notes](wazuh-siem/setup-notes.md)
- [Security+ applied: network segmentation](security-plus-applied/network-segmentation.md)
- [Security+ applied: SIEM vs. IDS](security-plus-applied/siem-vs-ids.md)
- [Screenshot safety guide](screenshots/README.md)
- [Synthetic lab environment](synthetic-lab/example-environment.md)

## Evidence Status

The completed entries are reconstructed lab simulations built from invented data. They demonstrate analysis, testing, rule design, and reporting methods without claiming to be exports from a live environment. Each entry identifies what must be rerun and replaced when an authorized lab is available.

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
