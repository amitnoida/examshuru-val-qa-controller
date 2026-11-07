#!/usr/bin/env bash
set -euo pipefail

# Credential-free gate: public logs intentionally report only coarse status.
fail() { echo "::error::controller trust gate denied"; exit 1; }
[[ "${GITHUB_REPOSITORY:-}" == "amitnoida/examshuru-val-qa-controller" ]] || fail
[[ "${GITHUB_EVENT_NAME:-}" == "push" ]] || fail
[[ "${GITHUB_REF:-}" == "refs/heads/main" ]] || fail
[[ "${REF_PROTECTED:-}" == "true" ]] || fail
[[ "${GITHUB_RUN_ATTEMPT:-}" == "1" ]] || fail
[[ "${GITHUB_ACTOR_ID:-}" == "58594631" ]] || fail
echo "Protected controller trust gate: PASS (no credentials loaded)"
