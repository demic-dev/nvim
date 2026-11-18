# AGENTS.md

Michele's personal Neovim configuration. It needs Neovim 0.12 and loads plugins with `vim.pack`, so plugins come from git and not from nix.

## Where things are

- `README.md` describes the layout, the plugin loader and the external tools. Read it before adding a feature.
- A feature is one file in `lua/plugins/<area>/`. That file declares its own plugins with `vim.pack.add`. Plugins are not listed in `flake.nix`.
- `flake.nix` lists the external tools on PATH, such as language servers and formatters. A tool that a feature needs goes there.
- `nvim-pack-lock.json` pins the plugin commits. Change it only with `:lua vim.pack.update()`, as the README says.

## Checks

Run both before you report a change as done:

```
d=$(mktemp -d) && ln -s "$PWD" "$d/nvim" && ! XDG_CONFIG_HOME="$d" nvim --headless "+qa" 2>&1 | grep -E '^Error|failed:'
nix flake check --no-build
```

The first command prints nothing and exits 0 when every feature loads. `nvim` exits 0 even when a feature fails, so the `grep` is what reports the failure. The first run downloads plugins and treesitter parsers from GitHub. `nix flake check --no-build` evaluates the flake for the current system only.

## Local rules

- Write comments and documentation in Standard Technical English: precise terminology, complete declarative sentences, no colloquialisms, hedging or filler. This replaces the plain-words rule for this repo.
