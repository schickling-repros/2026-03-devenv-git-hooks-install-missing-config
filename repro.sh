#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
home_dir="$repo_root/.tmp-home"

mkdir -p "$home_dir"
cd "$repo_root"

export HOME="$home_dir"
export GIT_CONFIG_GLOBAL=/dev/null

git config user.name repro
git config user.email repro@example.com

rm -rf .devenv .tmp-home
mkdir -p "$home_dir"

echo "Installing hooks..."
devenv tasks run devenv:git-hooks:install --no-tui

if [ -e .pre-commit-config.yaml ]; then
  echo "Expected .pre-commit-config.yaml to be missing, but it exists"
  exit 1
fi

echo "Confirmed: .pre-commit-config.yaml is missing after install"
echo "Running commit..."

set +e
commit_output="$(git commit --allow-empty -m repro 2>&1)"
commit_status=$?
set -e

printf '%s\n' "$commit_output"

if [ "$commit_status" -eq 0 ]; then
  echo "Expected git commit to fail, but it succeeded"
  exit 1
fi

printf '%s\n' "$commit_output" | grep -F 'config file not found: `.pre-commit-config.yaml`' >/dev/null

echo "Reproduced"
