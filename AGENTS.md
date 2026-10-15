# ai-tools-catalog — agent contract

This public repository groups upstream tool catalogs as Git submodules. It owns setup guidance and catalog pointers; tool implementation and release ownership remain upstream.

- Work on a `codex/` branch and open a PR against `main`. Do not push changes directly to `main` or merge without owner authorization.
- Fetch before editing existing files. Preserve changes that are not yours.
- Read the relevant submodule's `AGENTS.md` before working inside it. Make upstream changes in its own branch/PR, then update this repository's pointer after they reach upstream `main`.
- All direct submodules track `main` in `.gitmodules`. Gitlinks still pin exact commits. Use `./setup.sh --latest` for current upstream main, and `./setup.sh` for recorded commits. Never describe either as automatic background updates.
- Preserve nested dependency pins. Do not use recursive `--remote` updates.
- Keep the root README a setup entry point, not a duplicated tool inventory. Catalog READMEs and manifests own the tool list and prerequisites.
- Setup must be repeatable, preserve local work, and avoid executing downloaded scripts or changing user-level agent configuration implicitly. Agent installation is a separate explicit action.
- Keep public files generic: no secrets, private URLs, client material, or machine-specific paths.
- Validate changes with `bash -n setup.sh`, `shellcheck setup.sh` when available, and a fresh clone running `./setup.sh` twice with no tracked diff. For an update, also validate `--latest` and inspect the submodule diff.

<!-- mathai-repo-operations:start -->
## Resource cleanup and review

Existing repository-specific retention, immutable-evidence and review/check requirements remain in force. This section does not override longer retention or stricter preservation rules.

Before cleanup, inspect `git status --short`, `git worktree list`, tracked files, ignored/untracked files and active processes. Read this repository's build configuration and `.gitignore` to identify reproducible outputs. Produce a bounded dry-run list with paths, ownership, active-use checks and a recovery plan; remove only confirmed inactive regenerable residue. A directory being ignored does not make it disposable. Never use broad `git clean`, forced worktree removal or recursive deletion across projects.

Stop only temporary processes created by the current task after they are no longer needed. Keep ordinary operational logs for five days, except evidence needed for an open issue. Preserve sources, credentials, local/ignored work and all experiment/evaluation records awaiting human assessment. Age alone does not authorize deletion of projects or conversations. Use the owning application's archive/recovery mechanism for managed worktrees. Report measured cleanup results and unresolved items in short bullets.

### Code Review Rules

Focus on correctness, data loss, security, permission expansion, costs and broken external contracts. State the concrete trigger and consequence of a finding. Put formatting and deterministic checks in CI. Missing required evidence is unverified, not success. Preserve repository-specific human approval and merge rules; this section grants no new merge authority. Report useful architectural decisions separately from blocking risks, in plain language.

<!-- mathai-repo-operations:end -->
