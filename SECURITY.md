# ExamShuru VAL QA Controller — Security Boundary

This **public** repository is an isolated control-plane experiment for the **private** `amitnoida/cbse-question-bank` application. It contains no private application source, test identities, screenshots, database connection strings, or live credentials.

## Current activation state

**NOT AUTHORIZED FOR LIVE VAL TESTS.** All workflows in the setup branch are credential-free. Do not add secrets or enable privileged jobs until every gate below is verified and separately reviewed.

1. GitHub Free branch protection must be enforced on `main`; disallow force pushes and deletions, require reviewed changes for controller workflow files, and check the actual `github.ref_protected` value in a real hosted run.
2. Privileged workflows must never run from a fork-originated PR, `pull_request_target`, unprotected branch, self-hosted runner, or a branch writable by unreviewed contributors. Keep GITHUB_TOKEN permissions minimum.
3. Retrieve exact-SHA reviewed test scripts and exact-SHA deployed application code from the private repository using a **single-repository, read-only, short-lived** fine-grained credential. Never execute workflows supplied by the source repo as trusted code.
4. Verify live Vercel project/domain/deployment/commit matching before any session or database operation. Only VAL-specific credentials and specific approved fixtures; never use PRD credentials or generic production tokens.
5. Public GitHub Actions logs, artifacts, caches and job summaries must contain **no** student email, session identifier, query result, credential, stack trace with PII, screenshot, authenticated trace, or verbose failed command output. Masking alone does not prove sanitization. Run synthetic failure-path checks with harmless test identifiers before any credential-bearing workflow.
6. Prove negative security tests, session cleanup and membership rollback. Independent review and owner authorization must precede a bounded live run.
7. The existing protected caller on the **private** app repository remains fail-closed and is **not** to be bypassed.

## Scope

Only credential-free trust checks and controller design may be merged before these conditions are met. No permission to modify PRD, merge release PRs, or expose source/evidence is implied.

See private application [Issue #124](https://github.com/amitnoida/cbse-question-bank/issues/124) for the release gates.
