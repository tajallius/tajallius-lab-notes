#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  segmentation-validation.sh
  segmentation-validation.sh [--execute --authorized] \
    --test-id ID \
    --source-zone LABEL \
    --destination-label LABEL \
    --protocol tcp|http|https \
    --target HOST_OR_IP \
    --port PORT \
    --expect allow|deny \
    [--timeout SECONDS]

The default is PLAN ONLY and sends no traffic. Execution requires both
--execute and --authorized. Run the command from the declared source zone.
USAGE
}

print_plan() {
  cat <<'PLAN_OUTPUT'
PLAN ONLY — no traffic was sent.

Suggested authorized checks:
  SEG-001  VLAN-MGMT  -> VLAN-BLUE   approved administration  expect allow
  SEG-002  VLAN-BLUE  -> VLAN-LOGS   security telemetry       expect allow
  SEG-003  VLAN-RED   -> VLAN-MGMT   administrative service   expect deny
  SEG-004  VLAN-RED   -> VLAN-GUEST  approved exercise path   expect allow
  SEG-005  VLAN-GUEST -> VLAN-MGMT   administrative service   expect deny

Supply the real target only at execution time. The script cannot verify that
the host running it is actually connected to the declared source zone.
PLAN_OUTPUT
}

execute=false
authorized=false
test_id=""
source_zone=""
destination_label=""
protocol=""
target=""
port=""
expectation=""
timeout=3

while [[ $# -gt 0 ]]; do
  case "$1" in
    --execute) execute=true; shift ;;
    --authorized) authorized=true; shift ;;
    --test-id) test_id="${2:-}"; shift 2 ;;
    --source-zone) source_zone="${2:-}"; shift 2 ;;
    --destination-label) destination_label="${2:-}"; shift 2 ;;
    --protocol) protocol="${2:-}"; shift 2 ;;
    --target) target="${2:-}"; shift 2 ;;
    --port) port="${2:-}"; shift 2 ;;
    --expect) expectation="${2:-}"; shift 2 ;;
    --timeout) timeout="${2:-}"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) printf 'Error: unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
done

if [[ -z "$test_id$source_zone$destination_label$protocol$target$port$expectation" ]]; then
  print_plan
  exit 0
fi

for required in test_id source_zone destination_label protocol target port expectation; do
  if [[ -z "${!required}" ]]; then
    printf 'Error: --%s is required.\n' "${required//_/-}" >&2
    exit 2
  fi
done

if [[ "$protocol" != "tcp" && "$protocol" != "http" && "$protocol" != "https" ]]; then
  printf 'Error: protocol must be tcp, http, or https.\n' >&2
  exit 2
fi

if [[ "$expectation" != "allow" && "$expectation" != "deny" ]]; then
  printf 'Error: expectation must be allow or deny.\n' >&2
  exit 2
fi

if ! [[ "$port" =~ ^[0-9]+$ ]] || (( port < 1 || port > 65535 )); then
  printf 'Error: port must be between 1 and 65535.\n' >&2
  exit 2
fi

if ! [[ "$timeout" =~ ^[0-9]+$ ]] || (( timeout < 1 || timeout > 30 )); then
  printf 'Error: timeout must be between 1 and 30 seconds.\n' >&2
  exit 2
fi

target_lower="$(printf '%s' "$target" | tr '[:upper:]' '[:lower:]')"
if [[ "$target" == -* || "$target" =~ [[:space:]] ]] ||
   [[ "$target_lower" == *"replace_me"* || "$target_lower" == target_* ||
      "$target_lower" == *"placeholder"* || "$target_lower" == *.invalid ||
      "$target_lower" == *.example || "$target_lower" == *.test ||
      "$target_lower" == "localhost" || "$target_lower" == "0.0.0.0" ||
      "$target_lower" == "127."* || "$target_lower" == "169.254.169.254" ||
      "$target_lower" == "192.0.2."* || "$target_lower" == "198.51.100."* ||
      "$target_lower" == "203.0.113."* || "$target_lower" == "2001:db8"* ]]; then
  printf 'Error: target is a placeholder, loopback, metadata, or documentation-only address.\n' >&2
  exit 2
fi

printf 'Test: %s\nSource zone: %s\nDestination: %s\nProtocol: %s\nTarget: %s:%s\nExpected: %s\n' \
  "$test_id" "$source_zone" "$destination_label" "$protocol" "$target" "$port" "$expectation"
printf 'Operator check: run this command from the declared source zone; the script cannot verify source placement.\n'

if [[ "$execute" != true ]]; then
  printf 'PLAN ONLY — no traffic was sent. Add --execute --authorized after confirming scope.\n'
  exit 0
fi

if [[ "$authorized" != true ]]; then
  printf 'Error: execution requires --authorized to confirm permission for this target.\n' >&2
  exit 2
fi

set +e
if [[ "$protocol" == "tcp" ]]; then
  nc -z -w "$timeout" "$target" "$port"
  command_status=$?
else
  curl --silent --show-error --output /dev/null --connect-timeout "$timeout" \
    "${protocol}://${target}:${port}/"
  command_status=$?
fi
set -e

if [[ "$expectation" == "allow" && $command_status -eq 0 ]]; then
  printf '[PASS] Connection succeeded as expected.\n'
  exit 0
fi

if [[ "$expectation" == "deny" && $command_status -ne 0 ]]; then
  printf '[PASS] Connection did not succeed as expected.\n'
  printf 'Corroborate this with gateway logs: a failure can also mean routing or service availability.\n'
  exit 0
fi

printf '[FAIL] Observed command status %s did not match the expected %s result.\n' \
  "$command_status" "$expectation" >&2
exit 1
