# .github

Organization profile, community health files, and reusable CI workflows for all nomux repositories.

This repository is a part of [nomux](https://github.com/nomux-sh), a native and lightweight agentic development environment. Sessions stay alive on the host when the client disconnects.

## Status

In development. Versions earlier than 1.0.0 are pre-releases: interfaces can change between minor versions.

## Contents

| Path | Purpose |
|---|---|
| `profile/README.md` | Organization profile. |
| `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `SUPPORT.md` | Default community health files for the organization. |
| `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md` | Default issue and pull request templates. |
| `RELEASING.md` | Versioning, changelog and release steps for all repositories. |
| `.github/workflows/rust-ci.yml`, `buf-ci.yml`, `dco.yml`, `commitlint.yml`, `repo-lint.yml` | Reusable workflows. |
| `standards/` | Source of the files that each repository has in the same form: the organization block of `AGENTS.md`, the commit hook and the label set. |
| `AGENTS.md`, `CLAUDE.md`, `QWEN.md` | Rules for coding agents in this repository. |
| `.github/workflows/ci.yml`, `self-test.yml` | Checks for this repository. |
| `tests/fixtures/` | Small Rust and Buf projects for the self-test. |

GitHub applies the community health files and the templates to each repository of the organization that does not have its own file. Refer to the GitHub documentation about [default community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file).

## Reusable workflows

All five workflows use `on: workflow_call`. They do not use secrets. They need only `contents: read` permission.

The file names and the input names are a contract. Other repositories depend on them. Do not rename a file or an input without a change in each caller.

Callers use the `main` branch:

```yaml
uses: nomux-sh/.github/.github/workflows/<file>@main
```

### `rust-ci.yml`

| Input | Type | Default | Description |
|---|---|---|---|
| `os` | string | `'["ubuntu-latest"]'` | JSON array of runner labels for the `clippy` and `test` jobs. |
| `working-directory` | string | `.` | Directory that contains the Cargo workspace. |
| `run-deny` | boolean | `true` | Run the `deny` job. |
| `run-machete` | boolean | `true` | Run the `machete` job. |

| Job | Runner | Command |
|---|---|---|
| `fmt` | `ubuntu-latest` | `cargo fmt --all --check` |
| `clippy` | each entry of `os` | `cargo clippy --workspace --all-targets -- -D warnings` |
| `test` | each entry of `os` | `cargo nextest run --workspace`, then `cargo test --workspace --doc` |
| `deny` | `ubuntu-latest` | `cargo deny check` |
| `machete` | `ubuntu-latest` | `cargo machete` |

Caller requirements:

- A `rust-toolchain.toml` file in the working directory or in a parent directory. The workflow installs this toolchain with `rustup`. If the file is missing, the workflow fails.
- A `deny.toml` file in the working directory when `run-deny` is `true`.
- At least one test. `cargo nextest run` fails when it finds no tests.
- At least one library target. `cargo test --doc` fails when the workspace has no library.

The `clippy` and `test` jobs cache dependencies with `Swatinem/rust-cache`. Tool versions are pinned in the workflow: `cargo-nextest` 0.9.152, `cargo-deny` 0.22.1, `cargo-machete` 0.10.1.

To build on more operating systems, add runner labels to `os`, for example `'["ubuntu-latest", "macos-latest"]'`.

```yaml
name: CI

on:
  pull_request:
  push:
    branches: [main]

permissions:
  contents: read

jobs:
  rust:
    uses: nomux-sh/.github/.github/workflows/rust-ci.yml@main
    with:
      os: '["ubuntu-latest"]'
      working-directory: .
      run-deny: true
      run-machete: true
```

### `buf-ci.yml`

| Input | Type | Default | Description |
|---|---|---|---|
| `working-directory` | string | `.` | Directory that contains `buf.yaml`. |
| `breaking-against` | string | empty | Value for `buf breaking --against`. If the value is empty, the breaking check does not run. |

The workflow has one job, `buf`, with three checks: `buf lint`, `buf format --diff --exit-code`, and `buf breaking --against <breaking-against>`. A failed check does not stop the subsequent checks. The checks are in one job because each check takes seconds, and one job installs `buf` only one time. The `buf` version is pinned in the workflow: 1.75.0.

The workflow passes `breaking-against` to `buf` without a change. The value is relative to `working-directory`. When the value is not empty, the workflow fetches the full history with tags and creates a local branch for each remote branch. Thus these values work:

| Value | Compares with |
|---|---|
| `.git#branch=main` | The `main` branch. |
| `.git#tag=v0.1.0` | A tag. |
| `../.git#branch=main,subdir=proto` | The `main` branch, when `working-directory` is `proto`. |

```yaml
jobs:
  buf:
    uses: nomux-sh/.github/.github/workflows/buf-ci.yml@main
    with:
      working-directory: .
      breaking-against: .git#branch=main
```

### `dco.yml`

No inputs. Call this workflow from a `pull_request` event.

The workflow checks each commit in the pull request for a `Signed-off-by: Name <email>` trailer. It skips merge commits. It does not compare the trailer with the commit author.

```yaml
jobs:
  dco:
    if: github.event_name == 'pull_request'
    uses: nomux-sh/.github/.github/workflows/dco.yml@main
```

### `commitlint.yml`

No inputs. Call this workflow from a `pull_request` event.

The workflow checks the pull request title and the message of each commit against the commit rules in [`CONTRIBUTING.md`](CONTRIBUTING.md). It skips merge commits. The format is `type: description`, with no scope. A `!` before the colon is optional. The permitted types are `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style` and `test`. A commit subject has 72 characters at most and a pull request title has 70. A `Co-authored-by` line or a "generated with" line fails the check.

To check a changed title, add the `edited` type to the trigger of the caller:

```yaml
on:
  pull_request:
    types: [opened, edited, synchronize, reopened]

jobs:
  commitlint:
    uses: nomux-sh/.github/.github/workflows/commitlint.yml@main
```

### `repo-lint.yml`

| Input | Type | Default | Description |
|---|---|---|---|
| `license` | string | `code` | `code` requires `LICENSE-MIT` and `LICENSE-APACHE`. `docs` requires `LICENSE`. |
| `require-changelog` | boolean | `true` | Require `CHANGELOG.md`. |
| `standards-ref` | string | `main` | Ref of this repository that has the source of the shared files. |

The workflow checks these items in the calling repository:

- The standard files exist: `README.md`, the license files, `CHANGELOG.md`, `AGENTS.md`, `CLAUDE.md`, `QWEN.md`, `.githooks/commit-msg`, `.github/CODEOWNERS` and `.github/dependabot.yml`.
- `CLAUDE.md` and `QWEN.md` have the line `@AGENTS.md`.
- The organization block of `AGENTS.md` agrees with `standards/AGENTS.common.md`.
- `.githooks/commit-msg` agrees with `standards/commit-msg` and is executable.
- The text does not use the words that the organization rules prohibit.

```yaml
jobs:
  repo-lint:
    uses: nomux-sh/.github/.github/workflows/repo-lint.yml@main
```

## Checks for this repository

- `ci.yml` runs `actionlint` 1.7.12 on all workflow files and `repo-lint.yml` on this repository. On pull requests, it also runs `dco.yml` and `commitlint.yml`.
- `self-test.yml` runs `rust-ci.yml` and `buf-ci.yml` on the projects in `tests/fixtures/`. It runs only when a pull request changes these workflows or the fixtures.

To run the lint on your computer:

```sh
actionlint
```

All actions are pinned to a full commit SHA with a version comment. When you update an action, change the SHA and the comment together.

There is no Markdown link check in this repository.

## License

Licensed under either of [Apache License, Version 2.0](LICENSE-APACHE) or [MIT license](LICENSE-MIT) at your option.

`CODE_OF_CONDUCT.md` is adapted from the Contributor Covenant and is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
