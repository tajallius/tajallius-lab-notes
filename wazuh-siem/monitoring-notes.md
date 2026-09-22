# Wazuh Monitoring Notes

These notes organize defensive monitoring work while keeping public evidence sanitized.

## Monitoring Goals

- Confirm that authorized lab endpoints report consistently.
- Identify authentication anomalies in test data.
- Observe configuration and file-integrity changes.
- Review severity, context, and likely false positives.
- Connect alerts to documented response actions.
- Improve rules based on repeatable lab observations.

## Alert Review Template

- **Use case:**
- **Generic asset label:**
- **Event category:**
- **Detection source:**
- **Severity rationale:**
- **Sanitized observation:**
- **Analyst decision:**
- **Response action:**
- **Tuning opportunity:**
- **Evidence reference:**

## Example Defensive Exercises

| Exercise | Expected monitoring outcome |
|---|---|
| Repeated failed authentication in an authorized test | Alert is generated and reviewed |
| Approved change to a monitored lab file | Change is recorded with useful context |
| Agent communication interruption | Visibility gap is identified |
| Benign activity that triggers an alert | False-positive cause is documented and tuned carefully |

## Data-Handling Rules

- Use synthetic test accounts and sample data.
- Redact addresses, hostnames, usernames, file paths, unique rule IDs, and environment details.
- Do not copy raw events into public notes.
- Share only the minimum evidence needed to explain the lesson.
- Store sensitive investigation material outside the public repository.
