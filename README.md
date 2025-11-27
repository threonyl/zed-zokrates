# ZoKrates for Zed

This is a [Zed](https://zed.dev/) extension for the [ZoKrates](https://zokrates.github.io/) language.

## Features

- Syntax highlighting
- Code outline
- Auto-indentation
- Bracket matching

## Installation

### Dev Extension

1. Open Zed.
2. Open the Command Palette (`Cmd+Shift+P`) and select `zed: install dev extension`.
3. Select this directory (`zed-zokrates`).

## Development

The grammar is located in the [tree-sitter-zokrates](https://github.com/threonyl/tree-sitter-zokrates) repository.

### Verification

To verify the extension queries against the grammar:

```bash
./verify.sh
```
