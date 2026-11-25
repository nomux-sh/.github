# Contributing to nomux

This guide applies to all repositories of the [nomux-sh](https://github.com/nomux-sh) organization. A repository can add rules in its own `CONTRIBUTING.md`.

All participants must obey the [Code of Conduct](CODE_OF_CONDUCT.md).

## Before you start

- For a bug or a small change, open an issue or a pull request in the applicable repository.
- For a large change, open an issue first. Get agreement on the design before you write the code.
- For a vulnerability, do not open an issue. Obey the [security policy](SECURITY.md).

## Sign-off (DCO)

nomux uses the [Developer Certificate of Origin 1.1](https://developercertificate.org/). There is no contributor license agreement.

Each commit must have a `Signed-off-by` trailer with your name and your email address:

```text
Signed-off-by: Your Name <you@example.com>
```

The trailer certifies that you have the right to submit the change under the license of the repository.

To add the trailer, use the `-s` option:

```sh
git commit -s
```

To add the trailer to all commits of a branch, rebase the branch:

```sh
git rebase --signoff main
```

CI checks the trailer of each commit in a pull request.

## Commit messages

A commit message is one subject line and the `Signed-off-by` trailer:

```text
type: description
```

- The permitted types are `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style` and `test`.
- Do not use a scope.
- Add `!` before the colon for a breaking change.
- The subject has 72 characters at most. It says what changed, in plain English.
- Do not name a phase, a milestone or a ticket in the subject.
- `Signed-off-by` is the only trailer. Do not add `Co-authored-by`, a tool name or a "generated with" line.

Examples:

```text
feat: add credit windows to the QUIC channel
fix: close the PTY when the child exits
docs: add the glossary entry for "session"
```

Each repository has a commit hook that does this check. Enable it one time in each clone:

```sh
git config core.hooksPath .githooks
```

CI does the same check on the pull request title and on each commit. The changelog comes from these messages with `git-cliff`.

## Pull requests

- Make one logical change in each pull request. Use a short branch name that names the change.
- The title has the format of a commit subject, 70 characters at most.
- The description says what changed and why. Then it shows the commands that you ran and their real result.
- Add tests for the change. Write a small number of tests that catch real regressions.
- Make sure that all CI checks pass. Do not disable a check.
- Write code, comments, documentation and commit messages in English.

The maintainers merge with a rebase. Each commit of the pull request goes to `main` unchanged, thus each commit must obey the commit rules. The `main` branch has a linear history and accepts changes only through pull requests.

## Coding agents

Each repository has an `AGENTS.md` file with the rules for coding agents. The same rules apply to people. `CLAUDE.md` and `QWEN.md` refer to `AGENTS.md`. A change that an agent wrote must obey all rules of this guide. The person who opens the pull request is responsible for it.

## Releases

Read the [release guide](RELEASING.md).

## Architecture changes

An architecture change needs an architecture decision record (ADR). Examples of architecture changes are a new process model, a protocol change, a new core dependency or a change to the extension model.

1. Add the ADR to the `adr/` directory of the [`docs`](https://github.com/nomux-sh/docs) repository.
2. Get approval for the ADR.
3. Open the pull request for the implementation. Refer to the ADR in the description.

## Rust rules

These rules apply to all Rust repositories.

- Use the Rust 2024 edition.
- Pin the toolchain in `rust-toolchain.toml`. Record the minimum supported Rust version in each release note.
- Before you open a pull request, run these commands. CI runs the same commands.

  ```sh
  cargo fmt --all --check
  cargo clippy --workspace --all-targets -- -D warnings
  cargo nextest run --workspace
  cargo test --workspace --doc
  cargo deny check
  cargo machete
  ```

- Use published versions (crates.io or a git tag) for dependencies between nomux repositories. You can use `[patch]` with local directories during development. Do not commit a `[patch]` section. CI does not run with `[patch]`.
- Each repository has `README.md`, `LICENSE-MIT`, `LICENSE-APACHE`, `CHANGELOG.md` and a link to the security policy.
- The shared CI steps come from the reusable workflows in the [`.github`](https://github.com/nomux-sh/.github) repository.

## Licenses and third-party code

- Code is licensed under `MIT OR Apache-2.0`. Documentation is licensed under CC BY 4.0.
- Use third-party code only when its license is MIT, Apache-2.0, BSD, ISC, Zlib or MPL-2.0 (file level). Record each source in `THIRD_PARTY.md` and `NOTICE`.
- Do not copy code from GPL, AGPL or Commons Clause projects. `cargo deny` rejects dependencies with these licenses.
