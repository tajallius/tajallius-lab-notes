# Network Segmentation Testing Results

Use this template to document authorized tests after removing sensitive environment details.

## Test Record

| Field | Entry |
|---|---|
| Test ID | Generic reference, such as `SEG-TEST-A` |
| Objective | What security boundary is being validated |
| Source zone | Generic VLAN label |
| Destination zone | Generic VLAN label or approved service category |
| Expected result | Allow, deny, or alert |
| Observed result | Sanitized behavior only |
| Status | Pass, fail, or needs review |
| Evidence | Link to a reviewed, sanitized artifact |
| Date | Month and year are sufficient for public notes |

## Starter Test Scenarios

| Scenario | Expected behavior | Result |
|---|---|---|
| `VLAN-RED` attempts administrative access to `VLAN-MGMT` | Denied and logged | Not yet recorded |
| `VLAN-MGMT` uses an approved path to `VLAN-BLUE` | Allowed and logged as designed | Not yet recorded |
| `VLAN-BLUE` reaches an approved update service | Allowed | Not yet recorded |
| A lab zone requests an unapproved destination | Denied and reviewed | Not yet recorded |

## Observation Template

### Test ID

- **Objective:**
- **Method:**
- **Expected behavior:**
- **Sanitized observation:**
- **Status:**
- **Lesson learned:**
- **Follow-up:**

## Pre-Publication Check

Confirm that notes and evidence contain no credentials, addresses, MAC addresses, serial numbers, hostnames, usernames, client data, or unique infrastructure details.
