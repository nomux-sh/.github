# Standards

The source of the files that each nomux repository must have in the same form.

| File | Copy in each repository | Purpose |
|---|---|---|
| `AGENTS.common.md` | The organization block of `AGENTS.md` | Rules for people and coding agents. |
| `commit-msg` | `.githooks/commit-msg` | Local check of the commit message. |
| `labels.json` | Issue labels (GitHub settings) | One label set for all repositories. |
| `sync.sh` | Not copied | Copies the first two files into a clone. |

The reusable workflow `repo-lint.yml` fails when a copy does not agree with the source.

## Change a standard

1. Change the file here and merge the pull request.
2. For each repository, run `standards/sync.sh <path-to-clone>` and open a pull request there.

## Apply the labels

```sh
jq -c '.[]' standards/labels.json | while read -r label; do
  gh label create "$(jq -r .name <<<"$label")" --repo nomux-sh/<repository> --force \
    --color "$(jq -r .color <<<"$label")" --description "$(jq -r .description <<<"$label")"
done
```
