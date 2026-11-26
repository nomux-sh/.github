# nomux

nomux is a native and lightweight agentic development environment. Sessions stay alive on the host when the client disconnects.

## Status

In development. Versions earlier than 1.0.0 are pre-releases: interfaces can change between minor versions. The [documentation](https://nomux-sh.github.io/docs/) has the quick start, and the [roadmap](https://nomux-sh.github.io/docs/project/roadmap/) shows the state of the work. The [theme preview](https://nomux-sh.github.io/themes/) shows each theme.

## Install nomux

The newest version is 0.4.0. Install it with the script:

```sh
curl -fsSL https://raw.githubusercontent.com/nomux-sh/nomux/main/install.sh | sh
```

On macOS and Linux with Homebrew:

```sh
brew install nomux-sh/tap/nomux
```

## Released versions

| Part | Version | Install |
|---|---|---|
| [`nomux`](https://github.com/nomux-sh/nomux/releases) (`nomux`, `nomuxd`, `nomux-holder`) | 0.4.0 | The script or the Homebrew command above |
| [`nomux-proto`](https://crates.io/crates/nomux-proto), the protocol crate for Rust | 0.11.0 | `cargo add nomux-proto` |
| [`nomux-extension`](https://crates.io/crates/nomux-extension), the extension SDK for Rust | 0.1.2 | `cargo add nomux-extension` |
| [`@nomux-sh/extension`](https://www.npmjs.com/package/@nomux-sh/extension), the extension SDK for TypeScript | 0.1.2 | `npm install @nomux-sh/extension` |
| [`github.com/nomux-sh/extension-api/sdk/go`](https://pkg.go.dev/github.com/nomux-sh/extension-api/sdk/go), the extension SDK for Go | 0.1.2 | `go get github.com/nomux-sh/extension-api/sdk/go` |
| [`nomux-theme`](https://crates.io/crates/nomux-theme), the theme loader for Rust | 0.3.0 | `cargo add nomux-theme` |
| [`git`](https://github.com/nomux-sh/extensions/releases/tag/git@0.1.0) extension | 0.1.0 | Download the archive of your platform. See [Install a released extension](https://github.com/nomux-sh/extensions#install-a-released-extension). |
| [`agent-claude`](https://github.com/nomux-sh/extensions/releases/tag/agent-claude@0.1.0) extension (adapter for Claude Code) | 0.1.0 | The same steps as for `git`. |

Each extension needs nomux 0.4.0 or later.

## Repositories

| Repository | Content |
|---|---|
| [`nomux`](https://github.com/nomux-sh/nomux) | The core: session holder, daemon, client library and CLI. |
| [`proto`](https://github.com/nomux-sh/proto) | The protocol: message schemas and specifications. |
| [`extension-api`](https://github.com/nomux-sh/extension-api) | The extension SDKs for Rust, TypeScript and Go, and the manifest schema. |
| [`extensions`](https://github.com/nomux-sh/extensions) | The official extensions: `git` and `agent-claude`. |
| [`themes`](https://github.com/nomux-sh/themes) | The design tokens and the themes, with a [preview](https://nomux-sh.github.io/themes/). |
| [`desktop`](https://github.com/nomux-sh/desktop) | The desktop client. In development: it has no release yet. |
| [`docs`](https://github.com/nomux-sh/docs) | The [documentation site](https://nomux-sh.github.io/docs/) and the architecture decision records. |
| [`homebrew-tap`](https://github.com/nomux-sh/homebrew-tap) | The Homebrew formula. |
| [`.github`](https://github.com/nomux-sh/.github) | Organization profile, community health files and reusable CI workflows. |

## Contributions

Read the [contribution guide](https://github.com/nomux-sh/.github/blob/main/CONTRIBUTING.md) and the [code of conduct](https://github.com/nomux-sh/.github/blob/main/CODE_OF_CONDUCT.md). To report a vulnerability, read the [security policy](https://github.com/nomux-sh/.github/blob/main/SECURITY.md).

## License

Code is licensed under `MIT OR Apache-2.0`. Documentation is licensed under CC BY 4.0.
