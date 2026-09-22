#!/usr/bin/env bash
set -u

# Reconstructed lab artifact. Run only on networks you own or are authorized to test.
# Default behavior is dry-run; pass --execute to send the listed connection checks.

MODE="${1:-plan}"

run_check() {
  local test_id="$1"
  local expectation="$2"
  shift 2

  printf '\n[%s] Expected: %s\n' "$test_id" "$expectation"
  printf 'Command:'
  printf ' %q' "$@"
  printf '\n'

  if [[ "$MODE" == "--execute" ]]; then
    "$@"
    local result=$?
    printf '[%s] Exit code: %s\n' "$test_id" "$result"
  else
    printf '[%s] Dry run only. Pass --execute after confirming authorization.\n' "$test_id"
  fi
}

run_check "SEG-001" "ALLOW from DEMO-MGMT to DEMO-BLUE" \
  curl --silent --show-error --head --connect-timeout 3 https://10.77.20.15/

run_check "SEG-002" "ALLOW telemetry from DEMO-BLUE to DEMO-LOGS" \
  nc -zvw3 10.77.40.10 1514

run_check "SEG-003" "DENY from DEMO-RED to DEMO-MGMT" \
  nc -zvw3 10.77.10.10 22

run_check "SEG-004" "ALLOW temporary exercise path from DEMO-RED to DEMO-GUEST" \
  nc -zvw3 10.77.50.20 443

run_check "SEG-005" "DENY from DEMO-GUEST to DEMO-MGMT" \
  nc -zvw3 10.77.10.10 22
