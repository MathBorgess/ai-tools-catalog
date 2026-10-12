#!/usr/bin/env bash
# Requires Bash 3.2+ and Git; installs nothing outside this checkout.
set -euo pipefail
catalog_root=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
cd "$catalog_root"

case "${1:-}" in
  '') mode=pinned ;;
  --latest) mode=latest ;;
  --help|-h)
    cat <<'HELP'
Usage: ./setup.sh [--latest]
  (default) Initialize all submodules at the commits recorded by this checkout.
  --latest  Fetch main for skills-catalog and mcps-catalog, then initialize their
            nested submodules at the versions recorded by those repositories.
Does not install plugins, alter agent settings, commit, push, or merge.
HELP
    exit 0 ;;
  *) printf 'Unknown option: %s\n' "$1" >&2; exit 2 ;;
esac
if [ "$#" -gt 1 ]; then
  printf 'Expected at most one option. Run ./setup.sh --help.\n' >&2
  exit 2
fi

# Never overwrite edits, untracked files, or unpublished commits in a submodule.
# The expressions below run inside each submodule, not this shell.
# shellcheck disable=SC2016
git submodule foreach --quiet --recursive '
  if [ -n "$(git status --porcelain)" ]; then
    printf "Refusing to change %s: save its local changes first.\n" "$displaypath" >&2
    exit 1
  fi
  if [ -z "$(git for-each-ref --format="%(refname)" --contains HEAD refs/remotes/)" ]; then
    printf "Refusing to change %s: HEAD is not on a known remote ref.\n" "$displaypath" >&2
    exit 1
  fi
'

if [ "$mode" = pinned ]; then
  if git submodule status --recursive | LC_ALL=C grep -q '^+'; then
    printf 'A submodule differs from the recorded commit. Review/commit that change first, or use --latest.\n' >&2
    exit 1
  fi
  git submodule sync --recursive
  git submodule update --init --recursive
else
  # --remote applies ONLY to the two direct catalogs. Nested upstream pins stay
  # paired with the dependency versions selected by mcps-catalog itself.
  git submodule sync --recursive
  git submodule update --init --remote --checkout -- skills-catalog mcps-catalog
  git submodule sync --recursive
  git -C skills-catalog submodule update --init --recursive
  git -C mcps-catalog submodule update --init --recursive
fi

git submodule status --recursive
printf '\nCatalogs ready. See README.md for the installation route for your agent.\n'
