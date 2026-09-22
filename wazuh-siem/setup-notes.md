# Wazuh Setup Notes

This document provides a safe structure for recording a Wazuh lab deployment without publishing deployment-specific secrets or identifiers.

## Generic Components

- **Wazuh agent:** Collects relevant endpoint security data.
- **Wazuh manager:** Analyzes events and applies detection rules.
- **Indexer:** Stores searchable security event data.
- **Dashboard:** Supports investigation, visualization, and alert review.

## Generic Data Flow

```text
Authorized lab endpoint
        |
   Wazuh agent
        |
  encrypted event flow
        |
   Wazuh manager
        |
      indexer
        |
     dashboard
```

## Setup Checklist

- Define the authorized lab scope.
- Use generic system labels in public notes.
- Protect enrollment and service credentials.
- Verify encrypted communication between components.
- Limit dashboard and administration access.
- Apply supported updates.
- Set a reasonable event-retention period.
- Confirm time synchronization.
- Test alert generation with a harmless, authorized event.
- Document rollback and recovery steps privately.

## Public Evidence

Safe public evidence can include component roles, a redrawn architecture diagram, sanitized configuration excerpts, and a summary of lessons learned.

Do not publish enrollment keys, certificates, tokens, internal addresses, real hostnames, usernames, raw logs, or screenshots before review.
