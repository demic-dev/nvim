{
  description = "Personal Neovim configuration and its external tooling";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (
          system: f nixpkgs.legacyPackages.${system}
        );

      # Everything the config shells out to: language servers, formatters,
      # treesitter compilation, and the tools plugins expect on PATH.
      tools =
        pkgs: with pkgs; [
          lua-language-server
          nixd
          nixfmt
          basedpyright
          ruff
          vtsls
          svelte-language-server
          vscode-langservers-extracted
          vue-language-server
          gopls
          go
          nodejs
          tinymist
          typst
          zathura
          ripgrep
          fd
          lazygit
          tree-sitter
          gcc
          git
          wl-clipboard
        ];
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell { packages = tools pkgs; };
      });

      packages = forAllSystems (pkgs: {
        default = pkgs.buildEnv {
          name = "nvim-tools";
          paths = tools pkgs;
        };
      });
    };
}
