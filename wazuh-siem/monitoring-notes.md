# Wazuh Investigation Case Study (Reconstructed)

> **Evidence status:** Reconstructed methodology. This entry documents an investigation and tuning workflow; it is not a live Wazuh alert export. See the [evidence matrix](../EVIDENCE.md).

## Scenario

A monitored system produces repeated authentication failures from one source, followed by a successful login for the same account. The analyst must decide whether the sequence reflects user error, an authorized exercise, or possible credential abuse.

## Detection Objective

Escalate repeated authentication failures from the same decoded source without turning every isolated failure into a high-priority alert.

The companion [`wazuh-local-rules.xml`](../artifacts/wazuh-local-rules.xml) is a draft rule targeting Wazuh 4.x syntax. XML well-formedness is checked in CI; Wazuh compatibility and runtime behavior remain unverified.

## Investigation Sequence

| Stage | Review action | Decision point |
|---|---|---|
| Initial event | Confirm the event source, decoder, timestamp, account field, and source-address field | Are the normalized fields trustworthy? |
| Correlation window | Group failures by source, account, destination, and time window | Does the sequence exceed the documented threshold? |
| Successful login | Compare the later session with the failure burst | Was the login expected and attributable to an authorized user? |
| Endpoint context | Review process, session, and authentication telemetry | Is there evidence of execution, persistence, or lateral movement? |
| Response | Contain only when evidence and business context justify it | Would automated blocking create an avoidable lockout? |

## Query Templates

Adapt field names to the installed decoder and index mapping:

```text
rule.id:<custom-rule-id> AND data.srcip:<sanitized-source>
```

```text
agent.name:<sanitized-agent> AND data.dstuser:<sanitized-account> AND @timestamp:[now-15m TO now]
```

These are query patterns, not exported results.

## Tuning Rationale

The draft rule uses a threshold and time window so isolated failures remain searchable while a repeated sequence can be escalated. A same-source condition reduces unrelated aggregation, and a suppression interval may reduce duplicate alerts after the threshold.

Before using that logic, validate:

- The installed Wazuh version
- The correct parent rule for the actual authentication source
- Availability and meaning of decoded `srcip` and `dstuser` fields
- Threshold behavior with representative sanitized events
- Alert level, MITRE mapping, and suppression behavior
- False-positive impact on shared addresses and legitimate user mistakes

## Response Decision Framework

Do not treat the rule match alone as proof of compromise. Review identity context, source ownership, endpoint telemetry, session activity, and whether the behavior was expected. Containment should be proportionate to the available evidence.

## Runtime Verification Plan

1. Place the rule in a test Wazuh manager's local rules file.
2. Run `wazuh-logtest` with sanitized representative authentication events.
3. Confirm the selected parent rule and decoded fields.
4. Verify the threshold, correlation, description, level, MITRE mapping, and suppression behavior.
5. Record Wazuh and ruleset versions.
6. Retain original evidence privately and publish only a sanitized result.

## Current Result

Runtime validation is pending. No alert count, noise-reduction percentage, or successful correlation is claimed.

## References

- [Wazuh custom rules](https://documentation.wazuh.com/current/user-manual/ruleset/rules/custom.html)
- [Wazuh ruleset XML syntax](https://documentation.wazuh.com/current/user-manual/ruleset/ruleset-xml-syntax/rules.html)
