# rustq/homebrew-tap

Homebrew formulae for [rustq](https://github.com/rustq) projects.

rustq 项目的 Homebrew formula。

```shell
$ brew tap rustq/tap
$ brew install ptxlint
```

## Formulae

| | | |
|---|---|---|
| [ptxlint](Formula/ptxlint.rb) | Static analysis and performance lints for NVIDIA PTX, no GPU needed | [repo](https://github.com/rustq/ptxlint) · [crate](https://crates.io/crates/ptxlint) |

Everything here is also on crates.io, so `cargo install ptxlint` works just as well if you already have a Rust toolchain.

这里的东西 crates.io 上都有，已经装了 Rust 工具链的话 `cargo install ptxlint` 一样能用。

## Updating a formula

`url` points at a release tag and `sha256` is the hash of that tarball:

```shell
$ curl -sL https://github.com/rustq/ptxlint/archive/refs/tags/v0.0.4.tar.gz | shasum -a 256
```
