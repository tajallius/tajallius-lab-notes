# Security+ Applied: SIEM vs. IDS

A security information and event management platform and an intrusion detection system support different parts of defensive visibility.

## Comparison

| Capability | SIEM | IDS |
|---|---|---|
| Primary role | Centralize, correlate, search, and retain security events | Detect suspicious network or host activity |
| Typical input | Logs and alerts from multiple sources | Network traffic or host activity |
| Output | Correlated alerts, searches, dashboards, and investigation context | Detection alerts and event details |
| Strength | Broad context across systems | Focused detection near the observed activity |
| Limitation | Quality depends on data sources and tuning | Usually has a narrower view of the environment |

## How They Work Together

```text
Lab activity
   |
IDS or endpoint detection
   |
alert or event
   |
SIEM collection and correlation
   |
analyst review and response
```

## Applied Exercise

1. Generate a harmless event in an authorized lab.
2. Confirm that the detection control observes it.
3. Confirm that the SIEM receives the related event.
4. Compare the original detection detail with the SIEM context.
5. Record the outcome using generic system labels.
6. Remove or sanitize any sensitive evidence before publishing.

## Key Takeaway

An IDS can identify suspicious activity, while a SIEM helps combine that signal with other events for investigation and response. Neither replaces sound segmentation, access control, endpoint protection, or analyst judgment.
