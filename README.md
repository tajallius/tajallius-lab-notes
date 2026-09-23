# Tajallius Lab Notes

This repository contains reconstructed defensive-security case studies, reusable validation artifacts, and safe documentation practices.

It shows how security work can be scoped, tested, reviewed, and reported without exposing a real environment. Reconstructed exercises are clearly separated from verified checks; nothing here is presented as a live firewall or SIEM export.

## Project Status and Claim Boundaries

The concentrated early commit sequence represents the initial import and foundation build for this public repository. Its timing should not be read as evidence of a long-running public contribution history; sustained work will be visible only as the project develops over time.

This is a lab-based educational and publication portfolio. It demonstrates documented methodology, reconstructed exercises, reusable artifacts, and the static checks listed below. It is not evidence that consulting services were delivered to clients. Any future claim about a real engagement should be made only when it can be supported by authorized, sanitized evidence; otherwise the work should continue to be described as lab, educational, or publication work.

## Repository Map

- [Evidence matrix](EVIDENCE.md)
- [Segmentation validation case study](network-segmentation/testing-results.md)
- [Wazuh investigation case study](wazuh-siem/monitoring-notes.md)
- [Reusable technical artifacts](artifacts/README.md)
- [Network segmentation overview](network-segmentation/vlan-overview.md)
- [Firewall rule notes](network-segmentation/firewall-rules.md)
- [Wazuh setup notes](wazuh-siem/setup-notes.md)
- [Foundation note: network segmentation](foundations/network-segmentation.md)
- [Foundation note: SIEM and IDS](foundations/siem-vs-ids.md)
- [Screenshot safety guide](screenshots/README.md)
- [Illustrative reference architecture](illustrative-environment/reference-architecture.md)

## What Is Verified

GitHub Actions checks the segmentation script's shell syntax, runs ShellCheck, confirms that its safety gates remain in place, and checks that the Wazuh rule file is well-formed XML.

Those are static checks only. They do not prove that a network boundary blocked traffic, that a Wazuh manager loaded the rule, or that an alert fired. See [EVIDENCE.md](EVIDENCE.md) for the exact status of each artifact.

## Public Documentation Rules

This repository does not publish:

- Passwords, API keys, tokens, recovery codes, or other credentials
- Public IP addresses or exact private network ranges
- MAC addresses, serial numbers, asset tags, or device identifiers
- Real hostnames, usernames, email addresses, or client information
- Unredacted logs, alerts, configuration exports, or screenshots
- Details that could enable unauthorized access

Generic labels such as `VLAN-BLUE`, `VLAN-RED`, and `VLAN-MGMT` stand in for environment-specific identifiers.

## Documentation Standard

Each future lab entry should record:

1. The security objective
2. The design or test method
3. The expected behavior
4. The sanitized observation
5. The lesson learned
6. The evidence reference after a safety review

> Use these materials only on systems and networks you own or are authorized to test.
