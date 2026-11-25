<!-- nomux:common:start -->
## Organization rules

These rules apply to each repository of the nomux-sh organization. The source of this block is `standards/AGENTS.common.md` in the [`.github`](https://github.com/nomux-sh/.github) repository. Do not edit the block in other repositories. CI compares it with the source.

### Before you change something

- Read the code around the change. Use the names, the structure and the style that the repository already has.
- Use the terms of the [glossary](https://github.com/nomux-sh/docs/blob/main/src/content/docs/reference/glossary.md). One concept has one name in code, CLI, UI and documentation.
- An architecture change needs an ADR in the [`docs`](https://github.com/nomux-sh/docs) repository before the implementation.
- Check versions, APIs and file paths before you use them. Do not guess.

### Scope

- Make only the change that the task asks for. Do not add options, abstractions or helpers that the task does not need.
- Do not add a placeholder that looks like an implementation. If work is deferred, say it in the pull request.
- Validate input at system boundaries. Trust internal code.

### Code

- Comments: none by default. Write one line only for a reason that the code cannot show.
- Do not swallow errors. Do not add retries without a known cause.
- The performance targets of the project come before features. A change that breaks a target is not merged.
- Do not copy code from GPL, AGPL or Commons Clause projects.

### Tests

- Write a small number of tests that catch real regressions. Do not write tests that only repeat the current code.
- A test must fail when the behaviour that it guards is removed.
- Do not mock the thing that the test examines.

### Text

- Write code, comments, documentation, commit messages and pull requests in English.
- Use short sentences, the active voice and one word for one concept. Put the condition before the instruction.
- Do not use these words: delve, robust, seamless, seamlessly, leverage, utilize, harness, pivotal, intricate, furthermore, moreover, notably, cutting-edge, best-in-class.

### Commits

- One subject line: `type: description`. No scope. 72 characters at most.
- Types: `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`. Add `!` before the colon for a breaking change.
- The description says what changed, in plain English. Do not name a phase, a milestone or a ticket.
- Sign off each commit with `git commit -s`. `Signed-off-by` is the only trailer.
- Do not add `Co-authored-by`, a tool name or a "generated with" line to a commit or to a pull request.
- Enable the commit hook one time in each clone: `git config core.hooksPath .githooks`.

### Pull requests

- One logical change in each pull request. The branch name is short and names the change.
- The title has the format of a commit subject, 70 characters at most.
- The description says what changed and why, then shows the commands that you ran and their real result.
- Each commit in the pull request obeys the commit rules. The maintainers merge with a rebase, thus each commit goes to `main` unchanged.
- Do not merge when a check fails. Do not disable a check to make it pass.

### Never commit

- Secrets, tokens, keys or passwords.
- Paths, host names or account names of a local machine.
- Generated build output, editor files or local configuration.

### Before you push

1. Run the checks that the "Checks" section of this file lists.
2. Read your diff from top to bottom.
3. Make sure that the changelog and the documentation agree with the change.
<!-- nomux:common:end -->
