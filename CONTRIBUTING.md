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

Commit subjects and pull request titles must agree with [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/):

```text
type(scope)!: description
```

- The permitted types are `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style` and `test`.
- The scope is optional. Use lowercase letters.
- Add `!` for a breaking change.

Examples:

```text
feat(transport): add credit windows to the QUIC channel
fix(holder): close the PTY when the child exits
docs: add the glossary entry for "session"
```

CI checks the pull request title and each commit subject. The changelog comes from these messages with `git-cliff`.

## Pull requests

- Make one logical change in each pull request.
- Add tests for the change.
- Make sure that all CI checks pass.
- Fill in the pull request template.
- Write code, comments, documentation and commit messages in English.

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
