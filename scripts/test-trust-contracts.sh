#!/usr/bin/env bash
set -euo pipefail
gate="scripts/require-trusted-controller.sh"
run_case() {
  local expectation="$1"; shift
  local rc=0
  (export GITHUB_REPOSITORY=amitnoida/examshuru-val-qa-controller GITHUB_EVENT_NAME=push GITHUB_REF=refs/heads/main REF_PROTECTED=true GITHUB_RUN_ATTEMPT=1 GITHUB_ACTOR_ID=58594631; "$@" bash "$gate") >/dev/null 2>&1 || rc=$?
  if [[ "$expectation" == accept && "$rc" != 0 ]] || [[ "$expectation" == reject && "$rc" == 0 ]]; then echo "Contract test failed"; exit 1; fi
}
run_case accept env
run_case reject env REF_PROTECTED=false
run_case reject env GITHUB_EVENT_NAME=pull_request
run_case reject env GITHUB_REF=refs/heads/unprotected
run_case reject env GITHUB_ACTOR_ID=1234
run_case reject env GITHUB_RUN_ATTEMPT=2
run_case reject env GITHUB_REPOSITORY=untrusted/fork
echo "PASS — 7 no-secret trust contracts"
