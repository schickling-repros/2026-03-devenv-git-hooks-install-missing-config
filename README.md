# devenv git-hooks install succeeds but leaves missing config

`devenv tasks run devenv:git-hooks:install` succeeds, but the generated `prek`
hook points at `.pre-commit-config.yaml` even though that file is not created.
The next `git commit` fails immediately with `config file not found`.

## Reproduction

```bash
bash repro.sh
```

## Expected

After `devenv:git-hooks:install` succeeds, the generated hook should be usable.
At minimum, `.pre-commit-config.yaml` should exist if the hook is going to
reference it.

## Actual

`devenv:git-hooks:install` reports success, `.pre-commit-config.yaml` is still
missing, and `git commit --allow-empty -m repro` fails with:

```text
error: config file not found: `.pre-commit-config.yaml`
```

## Versions

- `devenv`: `2.0.2+22ec127`
- `git-hooks` input: current `github:cachix/git-hooks.nix`
- OS: `macOS 26.2`

## Related Issue

TBD
