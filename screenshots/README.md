# Screenshot Safety Guide

Screenshots can provide strong portfolio evidence, but they must be reviewed before being added to this public repository.

## Do Not Publish

- Passwords, tokens, keys, certificates, QR codes, or recovery codes
- Public IP addresses or exact private network ranges
- MAC addresses, serial numbers, asset tags, or device identifiers
- Real hostnames, usernames, email addresses, or personal names
- Client, employer, or third-party data
- Browser bookmarks, open tabs, notifications, or unrelated applications
- Full log entries or alerts containing unique environment details
- Hidden metadata that identifies a device, account, or location

## Safe Screenshot Workflow

1. Capture only the smallest relevant area.
2. Replace real labels with generic names when possible.
3. Redact sensitive information with solid, irreversible blocks.
4. Crop out unrelated interface areas.
5. Remove image metadata.
6. Review the final exported image at full size.
7. Ask a second reviewer to check it when possible.
8. Add a caption explaining what the image demonstrates.

## Naming Convention

Use descriptive, generic names such as:

```text
segmentation-policy-overview.png
sanitized-alert-example.png
generic-monitoring-dashboard.png
```

Avoid dates, usernames, hostnames, addresses, customer names, and device identifiers in filenames.

## Included Illustrative Mockup

![Illustrative monitoring dashboard](synthetic-siem-dashboard.png)

`synthetic-siem-dashboard.png` is a portfolio mockup, not a capture of a live monitoring platform and not runtime evidence.

Future images should be added only after completing this checklist.
