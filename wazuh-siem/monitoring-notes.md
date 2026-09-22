# Wazuh Alert Investigation: Reconstructed Lab Exercise

> **Evidence status:** Completed investigation against a fictional event sequence. The rule, timeline, queries, and tuning rationale are usable examples, but the alert counts and observations were reconstructed rather than exported from a live Wazuh deployment.

## Scenario

An invented source, `demo-red-01` (`10.77.30.25`), generated repeated failed authentication events for the fictional account `demo-analyst` on `demo-blue-01`. A later successful login required review because it followed the failure burst.

## Detection Objective

Escalate repeated authentication failures from the same source without turning every isolated typo into a high-severity alert.

The companion rule is available at [`artifacts/wazuh-local-rules.xml`](../artifacts/wazuh-local-rules.xml).

## Reconstructed Event Timeline

| Time UTC | Event | Wazuh treatment |
|---|---|---|
| `14:35:03` | Failed login for `demo-analyst` from `10.77.30.25` | Base authentication-failure event |
| `14:35:21` | Second failed login from the same source | Added to the correlation window |
| `14:35:44` | Third failed login from the same source | Custom rule `100100` reached threshold |
| `14:36:02` | Fourth failed login from the same source | Covered by the alert suppression period |
| `14:36:38` | Successful login for `demo-analyst` | Analyst review required |

## Example Alert Summary

```json
{
  "rule_id": "100100",
  "rule_level": 10,
  "description": "Lab simulation: repeated authentication failures for demo-analyst from 10.77.30.25",
  "agent": "demo-blue-01",
  "source_ip": "10.77.30.25",
  "destination_user": "demo-analyst",
  "failure_count": 3,
  "window_seconds": 120,
  "mitre_technique": "T1110",
  "evidence_note": "Invented alert for a reconstructed exercise"
}
```

## Investigation Query

The following Discover query narrows the reconstructed dataset to the custom alert and source:

```text
rule.id:100100 AND data.srcip:"10.77.30.25"
```

The surrounding authentication activity can be reviewed with:

```text
agent.name:"demo-blue-01" AND data.dstuser:"demo-analyst" AND @timestamp:[now-15m TO now]
```

Field availability depends on the decoder and data source, so these queries must be adjusted to the actual indexed document.

## Analyst Assessment

- The failures shared one source address, one destination asset, and one account within a short interval.
- The successful login after the failure burst increased the priority of the review.
- No real reputation, identity, or endpoint context exists in this reconstruction, so the scenario cannot support a true compromise determination.
- In a live lab, the next checks would include the source asset owner, process ancestry, endpoint telemetry, session activity, and whether the login was expected.

## Tuning Exercise

### Initial behavior

The fictional first draft raised a medium alert for every authentication failure. In a reconstructed dataset of 34 events, 31 were isolated failures and three belonged to the burst. That produced excessive noise.

### Revised behavior

The custom rule raises a level 10 alert after three events that matched parent rule `5503` within 120 seconds. The `same_srcip` correlation requires a common decoded source address, and `ignore="60"` reduces duplicate alerts after the threshold is reached.

### Reconstructed before-and-after result

| Measure | Before tuning | After tuning |
|---|---:|---:|
| Individual failure alerts requiring review | 34 | 0 high-priority alerts |
| Correlated high-priority alerts | 0 | 1 |
| Events retained for search | 34 | 34 |
| High-priority reduction | — | 97% fewer items in the analyst queue |

The reduction applies only to this invented dataset; it is not a measured production result.

## Response Decision

For the reconstructed scenario, the analyst would contain the source only after confirming that the successful login was unauthorized. Immediate automated blocking was not selected because the exercise lacks identity context and could otherwise lock out a legitimate user after repeated mistakes.

## Verification Plan

1. Place the example rule in a test Wazuh manager's local rules file.
2. Run `wazuh-logtest` with sanitized sample authentication events.
3. Confirm that the parent event includes decoded `srcip` and `dstuser` fields.
4. Verify one correlated alert after the third matching failure.
5. Confirm the alert description, level, MITRE mapping, and suppression behavior.
6. Replace reconstructed counts with actual sanitized test results.

## References

- [Wazuh custom rules documentation](https://documentation.wazuh.com/current/user-manual/ruleset/rules/custom.html)
- [Wazuh ruleset XML syntax](https://documentation.wazuh.com/current/user-manual/ruleset/ruleset-xml-syntax/rules.html)
