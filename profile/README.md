# nomux

nomux is a native and lightweight agentic development environment. Sessions stay alive on the host when the client disconnects.

## Status

In development. Versions earlier than 1.0.0 are pre-releases: interfaces can change between minor versions.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/nomux-sh/nomux/main/install.sh | sh
```

On macOS and Linux with Homebrew: `brew install nomux-sh/tap/nomux`. The [documentation](https://nomux-sh.github.io/docs/) has the quick start, and the [roadmap](https://nomux-sh.github.io/docs/project/roadmap/) shows the state of the work.

## Repositories

| Repository | Content |
|---|---|
| [`nomux`](https://github.com/nomux-sh/nomux) | The core: session holder, daemon, client library and CLI. |
| [`proto`](https://github.com/nomux-sh/proto) | The protocol: message schemas and specifications. |
| [`extension-api`](https://github.com/nomux-sh/extension-api) | The extension SDK: protocol, Rust crate and manifest schema. |
| [`extensions`](https://github.com/nomux-sh/extensions) | The official extensions. |
| [`themes`](https://github.com/nomux-sh/themes) | The design tokens and the themes, with a [preview](https://nomux-sh.github.io/themes/). |
| [`docs`](https://github.com/nomux-sh/docs) | The documentation site and the architecture decision records. |
| [`homebrew-tap`](https://github.com/nomux-sh/homebrew-tap) | The Homebrew formula. |
| [`.github`](https://github.com/nomux-sh/.github) | Organization profile, community health files and reusable CI workflows. |

## Contributions

Read the [contribution guide](https://github.com/nomux-sh/.github/blob/main/CONTRIBUTING.md) and the [code of conduct](https://github.com/nomux-sh/.github/blob/main/CODE_OF_CONDUCT.md). To report a vulnerability, read the [security policy](https://github.com/nomux-sh/.github/blob/main/SECURITY.md).

## License

Code is licensed under `MIT OR Apache-2.0`. Documentation is licensed under CC BY 4.0.
