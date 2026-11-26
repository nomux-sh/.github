# Releases

This guide applies to all repositories of the [nomux-sh](https://github.com/nomux-sh) organization that publish a version.

## Versions

- Versions obey [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html).
- Versions earlier than 1.0.0 are pre-releases. A minor version can have breaking changes. A patch version cannot.
- A beta or a release candidate has a suffix: `0.3.0-beta.1`, `1.0.0-rc.1`.
- The tag of a version is `v` and the version: `v0.3.0`.
- In a repository with one product, all crates and binaries have the same version.

## Changelog

- Each repository with releases has a `CHANGELOG.md` in the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.
- `git-cliff` writes the changelog from the commit subjects. The configuration is `cliff.toml` in the repository.
- The types `feat`, `fix`, `perf`, `refactor`, `docs` and `revert` go into the changelog. A subject with `!` goes into the "Breaking changes" group.
- The release note on GitHub is the changelog section of the version.
- The `homebrew-tap` repository has no `CHANGELOG.md`, because its releases hold only the bottles of a nomux release.

## Steps

1. Make sure that `main` is green and that the changelog section "Unreleased" is correct: `git cliff --unreleased`.
2. Open a pull request with the title `chore: release X.Y.Z`. It changes the version in the manifests and moves "Unreleased" to the new version in `CHANGELOG.md`: `git cliff --tag vX.Y.Z --output CHANGELOG.md`.
3. Merge the pull request after all checks pass.
4. Put the tag on the merge result and push it: `git tag -s vX.Y.Z -m vX.Y.Z` (or `-a` without a signing key), then `git push origin vX.Y.Z`.
5. The release workflow of the repository builds the artifacts, makes the GitHub release and publishes the packages.
6. Examine the release: download one artifact and run it.

Do not move or delete a tag after it is public. To correct a release, publish a new patch version.

## Artifacts

| Repository | Artifacts |
|---|---|
| `nomux` | Binaries `nomux`, `nomuxd` and `nomux-holder` for Linux (musl, x86_64 and aarch64) and macOS. Each archive has a SHA-256 checksum. |
| `proto` | The `nomux-proto` crate. |
| `docs` | The documentation site. Each merge to `main` publishes it. It has no version. |

The code signing of macOS and Windows artifacts starts with the first stable release.

## Dependency updates

Dependabot version updates run monthly, with one open pull request, and only for a new major version: each `dependabot.yml` ignores patch and minor updates. Do not add `groups` to a Dependabot configuration, because a grouped update gets a pull request title that is longer than 70 characters.
