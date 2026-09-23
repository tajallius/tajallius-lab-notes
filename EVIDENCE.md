# Evidence Matrix

This page distinguishes portfolio methodology from checks that have actually run. It is the source of truth for evidence claims in this repository.

| Artifact | Status | Verified | Not yet verified |
|---|---|---|---|
| Segmentation case study | Reconstructed methodology | Test scope, expected outcomes, collection plan, and reporting format are documented | No measured network result or gateway-log export is published |
| Wazuh investigation case study | Reconstructed methodology | Investigation sequence, tuning rationale, and runtime verification plan are documented | No live alert export or manager-side rule test is published |
| Segmentation validation script | Static validation | Shell syntax, ShellCheck, dry-run behavior, authorization gate, and placeholder rejection are checked in CI | The script has not demonstrated behavior across a real boundary |
| Wazuh custom rule | Static validation | The file is checked as well-formed XML in CI | Compatibility with a specific Wazuh release, parent rule, decoded fields, threshold, and suppression behavior require `wazuh-logtest` |
| Monitoring dashboard image | Illustrative mockup | It demonstrates a possible presentation format | It is not a capture from an operating SIEM and is not runtime evidence |
| Foundation notes | Reference material | Concepts and validation questions are documented | They are not evidence that a control was deployed or tested |

## Evidence Standard for a Future Live Entry

A live entry should include the authorized test scope, execution date, tool and version, expected result, sanitized command or query, observed result, corroborating control-plane evidence, and limitations. Original unredacted evidence should remain private.
