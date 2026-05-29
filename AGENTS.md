# AGENTS.md

## Purpose

This repository tracks AUR packages maintained by `bupd`.

The root GitHub repository, `bupd/aur`, is metadata and orchestration. The real AUR package repositories live in package submodules such as `dagger-git/`, `kitops/`, `harbor-cli/`, and `pack-cli-git/`.

For official package updates, treat each submodule as its own repository and source of truth. The root repository should only record the updated submodule commit pointer and open a small GitHub PR for review, CI, and merge.

## Safety Rules

- One package update equals one PR.
- Do not batch multiple package upgrades into one package PR.
- Do not manually edit `.SRCINFO`; generate it with `makepkg --printsrcinfo > .SRCINFO`.
- Only change the required `pkgver` line in `PKGBUILD` unless the package update requires more and the user explicitly approves it.
- Commit inside the package submodule first, push that AUR repo, then update the root repository submodule pointer.
- Ask before continuing if the target package name, target version, branch, label, CI result, or merge state is unclear.
- Never overwrite unrelated dirty work in the root repository or inside a submodule.

## Update Discovery

When the user asks to run the update workflow:

1. Check the latest open PR in `https://github.com/bupd/aur`.
2. Read the PR body.
3. Parse the `## Updates` diff block.
4. Identify package names with added target versions.
5. Map update names to submodule directories.
6. Plan one independent package update PR per package.

Example PR body:

```diff
-dagger: updated to 0.20.7
+dagger: updated to 0.21.0
-harbor-cli: updated to 0.0.19
+harbor-cli: updated to 0.0.22
```

This means:

- `dagger` should update the `dagger-git/` submodule to `pkgver=0.21.0`.
- `harbor-cli` should update the `harbor-cli/` submodule to `pkgver=0.0.22`.

## Package Name Mapping

- `dagger` -> `dagger-git/`
- `harbor-cli` -> `harbor-cli/`
- `kitops` -> `kitops/`
- `pack-cli` -> `pack-cli-git/`
- `oras` -> `oras-git/`
- `git-donkey` -> `git-donkey/`

Ask the user before proceeding if a package is not listed here.

## Single Package Update Workflow

Run this workflow for one package at a time.

1. Enter the package submodule.

```bash
cd <package-dir>
```

2. Confirm the submodule is clean or only contains expected changes for this package.

```bash
git status --short
git log --oneline -5
```

3. Update only `pkgver` in `PKGBUILD` to the target version.

```bash
pkgver=<target-version>
```

4. Regenerate `.SRCINFO`.

```bash
makepkg --printsrcinfo > .SRCINFO
```

5. Review the package diff.

```bash
git diff -- PKGBUILD .SRCINFO
```

6. Commit and push inside the submodule.

```bash
git add PKGBUILD .SRCINFO
git commit -sm "v<target-version>"
git push
```

Submodule commit messages do not use conventional commit prefixes. Use only the version, for example `v0.21.0`.

7. Return to the root repository and verify the submodule pointer changed.

```bash
cd ..
git status --short
git diff --submodule
```

8. Create a dedicated root branch for this package.

```bash
git switch -c update-<package-dir>-root
```

9. Commit the submodule pointer in the root repository.

```bash
git add <package-dir>
git commit -sm "feat: update <package-dir> to v<target-version>"
```

10. Push the root branch and open a GitHub PR.

```bash
git push -u origin update-<package-dir>-root
gh pr create --repo bupd/aur --base main --head update-<package-dir>-root --title "Update <package-dir> To V<target-version>" --body "Update <package-dir> to v<target-version>."
```

11. Add the same labels used by automated version update PRs unless the user specifies otherwise.

```bash
gh pr edit --repo bupd/aur <pr-number> --add-label automated --add-label version-update
```

12. Wait for CI.

```bash
gh pr checks --repo bupd/aur <pr-number> --watch
```

13. Merge only after CI passes and the PR contents are verified.

```bash
gh pr merge --repo bupd/aur <pr-number> --merge --delete-branch
```

14. Update local `main` before starting the next package.

```bash
git switch main
git pull --rebase origin main
git submodule update --init --recursive
```

## Verification Checklist

Before each package PR is opened:

- The target version came from the latest open update PR body.
- Only one package submodule changed in the root diff.
- Inside the submodule, only `PKGBUILD` and `.SRCINFO` changed.
- `.SRCINFO` was regenerated, not manually edited.
- The submodule commit was pushed to the AUR remote.
- The root commit uses the established conventional format.

Before each package PR is merged:

- GitHub Actions completed successfully.
- The PR contains only the expected submodule pointer change.
- The labels are correct.

## Stop And Ask

Stop and ask the user before continuing if:

- There are unexpected dirty files.
- The package directory is not a known submodule.
- The PR body does not clearly show old and new versions.
- `makepkg --printsrcinfo` changes more than expected.
- `git push`, PR creation, CI, or merge fails.
- A package update requires changing anything beyond `pkgver` and generated `.SRCINFO`.
