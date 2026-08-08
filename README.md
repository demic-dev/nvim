# nvim

Personal Neovim configuration. Requires Neovim >= 0.12 (uses `vim.pack` and the
builtin LSP API).

## Layout

```
init.lua                     leader key, core modules, plugin loader
lua/core/                    options, keymaps, autocmds, loader
lua/plugins/<area>/*.lua     one file per feature
after/ftplugin/              filetype-local settings
flake.nix                    devShell with every external tool
```

## Modularity

`lua/core/loader.lua` requires every `lua/plugins/**/*.lua`, sorted, skipping
files whose name ends in `-X.lua`.

- **Add a feature**: add a file. It calls `vim.pack.add{...}` itself and
  configures the feature. `vim.pack.add` is idempotent, so several files may
  share one repository (that is how the `mini.nvim` modules are split).
- **Disable a feature**: rename `foo.lua` to `foo-X.lua`.

Adding a language server is the same: drop a file in `lua/plugins/lsp/` that
calls `vim.lsp.config` and `vim.lsp.enable`.

## External tools

```
nix develop        # everything on PATH
nix build          # buildEnv of the same tools, for system config integration
```

Plugins are *not* managed by nix: `vim.pack` clones them into
`stdpath("data")/site/pack/core/opt`, which is what it requires. It pins their
commits in `nvim-pack-lock.json` next to this file — the plugin counterpart of
`flake.lock`. Update with `:lua vim.pack.update()`.

## Before first use

Set your Obsidian vault path in `lua/plugins/text/obsidian.lua` (marked with a
`TODO`). Until it points at a real directory, obsidian.nvim stays disabled.

## Trying it without replacing your config

```
NVIM_APPNAME=… nvim     # with this repo symlinked to ~/.config/<name>
```
