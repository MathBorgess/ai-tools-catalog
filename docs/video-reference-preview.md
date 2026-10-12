# Evaluate video-reference while its PRs are open

Check the current state of the [CLI PR](https://github.com/MathBorgess/video-reference/pull/1) and [skill PR](https://github.com/MathBorgess/skills-catalog/pull/72). Until they merge, upstream `main` and `setup.sh --latest` do not supply those implementations. Do not move the catalog's submodule pins to unmerged code just to make an evaluation work.

For an explicitly requested preview, use separate clean clones/worktrees of the PR branches, inspect their diffs and record exact commit SHAs. Reuse existing checkouts only after checking their remotes and local changes. The CLI README documents its review branch, Node.js22+ and FFmpeg/FFprobe requirements. It can run directly with `node bin/video-reference.mjs`; an npm global installation is optional. No unscoped npm package is implied.

Load the complete `skills/creativity/video-reference` folder from the matching skill checkout. For temporary evaluation an agent may read its SKILL.md directly; this is not proof that a managed plugin discovered the unpublished skill. If installation is requested, follow the selected agent's installer and preserve any existing version. Do not install duplicate managed and copied bundles. After merge, use the catalog's normal installation route and retire the preview copy deliberately.

Validate CLI `doctor`, help/schema and a disposable project. Reference descriptions may be distributed separately as a text snapshot; full analysis/review needs the original media and evidence in an authorized local project. A snapshot is not a media-complete installation.

Audio/motion interpretation runs in the agent's local toolchain. Reuse installed models where possible and disclose missing dependencies before installing them. Read the [CLI's local-analysis guide](https://github.com/MathBorgess/video-reference/blob/codex/initial-cli/docs/local-analysis.md) and [future acoustic-analysis issue](https://github.com/MathBorgess/video-reference/issues/2). Clone, skill discovery, runtime readiness and audiovisual fidelity are separate checks.
