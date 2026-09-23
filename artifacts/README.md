# Technical Artifacts

These files support the reconstructed case studies in this repository. Their exact evidence status is tracked in [`EVIDENCE.md`](../EVIDENCE.md).

## Segmentation Validation Script

[`segmentation-validation.sh`](segmentation-validation.sh) is plan-only by default. It contains no target addresses and executes one explicit check at a time.

```text
./artifacts/segmentation-validation.sh \
  --test-id SEG-001 \
  --source-zone VLAN-MGMT \
  --destination-label VLAN-BLUE \
  --protocol https \
  --target <authorized-target> \
  --port 443 \
  --expect allow
```

Review the plan, confirm the execution point is in the declared source zone, then add both `--execute` and `--authorized`. The target is supplied by the operator and is never committed here.

For an expected deny, a failed connection is not enough to prove the firewall caused it. Corroborate the result with the gateway rule, action, source zone, destination zone, and timestamp.

## Wazuh Rule

[`wazuh-local-rules.xml`](wazuh-local-rules.xml) is a draft Wazuh 4.x custom rule for correlating repeated authentication failures from one decoded source address.

Before loading it, confirm the parent rule ID and decoded fields in the installed Wazuh version, then test representative sanitized events with `wazuh-logtest`.

## Validation Status

| Check | Automated in CI | Requires an authorized environment |
|---|---|---|
| Shell syntax and ShellCheck | Yes | No |
| Script plan-only and authorization gates | Yes | No |
| Wazuh XML well-formedness | Yes | No |
| Network allow/deny behavior | No | Yes |
| Gateway-log corroboration | No | Yes |
| Wazuh rule loading, correlation, and suppression | No | Yes |

## References

- [Wazuh custom rules](https://documentation.wazuh.com/current/user-manual/ruleset/rules/custom.html)
- [Wazuh ruleset XML syntax](https://documentation.wazuh.com/current/user-manual/ruleset/ruleset-xml-syntax/rules.html)
