# ai-tools-catalog

One checkout for [Matheus Borges](https://github.com/MathBorgess)'s agent tools. This repository groups public catalogs and standalone tools as Git submodules; each upstream keeps its own code, releases, and installation instructions.

| Catalog | Contents | Install instructions |
| --- | --- | --- |
| [skills-catalog](skills-catalog/) | Agent workflows for engineering, creativity, and experiments | [Skills setup](skills-catalog/README.md#install) |
| [mcps-catalog](mcps-catalog/) | MCP servers, packaged as Claude Code plugins | [MCP setup](mcps-catalog/README.md#install) |
| [video-reference](video-reference/) | Local video reference libraries and HyperFrames direction CLI | [CLI repository](https://github.com/MathBorgess/video-reference) |

## Get everything

Requires Git and Bash (macOS, Linux, or Git Bash on Windows).

```bash
git clone https://github.com/MathBorgess/ai-tools-catalog.git
cd ai-tools-catalog
./setup.sh --latest
```

`--latest` fetches `main` for all direct submodules. Nested dependencies keep the commits selected by their parent catalog. Repeat the same command to update later.

The initial video-reference implementation is under review upstream. Its gitlink tracks the bootstrap commit on `main`; cloning this aggregator does not yet install a working CLI. Follow the [CLI implementation PR](https://github.com/MathBorgess/video-reference/pull/1) and [companion skill PR](https://github.com/MathBorgess/skills-catalog/pull/72) for evaluation. Once that PR merges, `--latest` retrieves the implementation, and a separate catalog PR can record its reviewed commit.

For the exact versions reviewed and recorded in this repository, run `./setup.sh` instead. A recursive clone also downloads those recorded versions:

```bash
git clone --recurse-submodules https://github.com/MathBorgess/ai-tools-catalog.git
```

Git submodules always record a commit. `branch = main` tells `--latest` which branch to fetch; it does not make a checkout update itself. After `--latest`, changed submodule pointers are expected in `git status` until a maintainer records them.

## Install in your agent

Cloning downloads the tools. Choose the installation route for your agent next. These commands use the upstream catalogs directly, so their managed plugin installations are independent of this checkout's recorded commits. Updating this checkout does not update installed plugins.

### Claude Code

Install the skills bundle:

```bash
claude plugin marketplace add MathBorgess/skills-catalog
claude plugin install skills-catalog@mathborgess
```

Register the MCP catalog and install the servers you need:

```bash
claude plugin marketplace add MathBorgess/mcps-catalog
claude plugin install speak@mathborgess-mcps
claude plugin install ultrafast-browser@mathborgess-mcps
claude plugin install laya-computer@mathborgess-mcps
```

MCP prerequisites differ. All three require `uv`; `speak` needs audio/model setup, and the two Laya tools require macOS on Apple Silicon plus their browser/desktop prerequisites. Follow the [MCP catalog's requirements](mcps-catalog/README.md#install) before installing. A plugin registration alone does not prove its server is ready.

If a marketplace is already registered, update it instead of adding it again:

```bash
claude plugin marketplace update mathborgess
claude plugin update skills-catalog@mathborgess
claude plugin marketplace update mathborgess-mcps
# Repeat for each installed MCP plugin:
claude plugin update speak@mathborgess-mcps
```

### Codex, Cursor, and other agents

Requires Node.js/npm. Pick either the Claude plugin route above or skills.sh for a given agent; installing both duplicates the skills.

```bash
npx skills add MathBorgess/skills-catalog
```

Choose the skills and target agents in the installer. For MCP clients other than Claude Code, use the launch command and environment described in each [server's README](mcps-catalog/README.md); this repository does not claim a universal MCP configuration format.

## Agent entry point

Standalone CLIs have their own setup. For video-reference, follow the upstream README once the implementation reaches main, then install the companion skill from skills-catalog. This wrapper does not install Node packages, FFmpeg, skills, or providers implicitly.

Read [AGENTS.md](AGENTS.md). For a setup request: run `./setup.sh --latest`, identify the target agent, then follow the relevant catalog's installation instructions and each selected server's prerequisites. Keep credentials in the user's environment. Report checkout success, plugin installation, and runtime verification separately.

## Maintenance

Tool changes belong in the relevant upstream repository. After they merge to its `main`, update the pointers here through a PR:

```bash
git switch main
git pull --ff-only
git switch -c codex/update-catalogs
./setup.sh --latest
git diff --submodule=log
git add skills-catalog mcps-catalog video-reference
git commit -m "Update catalog pointers"
git push -u origin HEAD
gh pr create --repo MathBorgess/ai-tools-catalog
```

Only commit when pointers changed. Review upstream changes before merging. Neither the setup script nor CI merges or pushes anything automatically.

The setup script refuses dirty submodules and commits absent from their known remote refs. Preserve or publish your work before rerunning it. Default setup also refuses a submodule pointer that differs from the recorded one; review and commit that pointer or explicitly choose `--latest`.

Do not recursively use `git submodule update --remote`: an upstream catalog may pin a nested dependency together with a runtime version, and changing only its submodule would break that pairing.

## License

The wrapper is MIT, see [LICENSE](LICENSE). Each catalog and nested dependency retains its own license.
