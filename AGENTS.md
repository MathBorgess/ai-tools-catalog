# ai-tools-catalog — agent contract

This public repository groups upstream tool catalogs as Git submodules. It owns setup guidance and catalog pointers; tool implementation and release ownership remain upstream.

- Work on a `codex/` branch and open a PR against `main`. Do not push changes directly to `main` or merge without owner authorization.
- Fetch before editing existing files. Preserve changes that are not yours.
- Read the relevant submodule's `AGENTS.md` before working inside it. Make upstream changes in its own branch/PR, then update this repository's pointer after they reach upstream `main`.
- Both direct submodules track `main` in `.gitmodules`. Gitlinks still pin exact commits. Use `./setup.sh --latest` for current upstream main, and `./setup.sh` for recorded commits. Never describe either as automatic background updates.
- Preserve nested dependency pins. Do not use recursive `--remote` updates.
- Keep the root README a setup entry point, not a duplicated tool inventory. Catalog READMEs and manifests own the tool list and prerequisites.
- Setup must be repeatable, preserve local work, and avoid executing downloaded scripts or changing user-level agent configuration implicitly. Agent installation is a separate explicit action.
- Keep public files generic: no secrets, private URLs, client material, or machine-specific paths.
- Validate changes with `bash -n setup.sh`, `shellcheck setup.sh` when available, and a fresh clone running `./setup.sh` twice with no tracked diff. For an update, also validate `--latest` and inspect the submodule diff.
