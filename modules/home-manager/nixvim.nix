{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.nixvim.enable = lib.mkEnableOption "enables nixvim home-manager module";

  config = lib.mkIf config.nixvim.enable {
    programs.ripgrep.enable = true;

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      globals.mapleader = ",";

      colorschemes.catppuccin.enable = true;

      opts = {
        updatetime = 100; # Faster completion
        number = true;
        relativenumber = true;
        splitbelow = true;
        splitright = true;
        shiftwidth = 4;
        scrolloff = 4;
        autoindent = true;
        clipboard = "unnamedplus";
        expandtab = true;
        smartindent = true;
        tabstop = 2;
        ignorecase = true;
        incsearch = true;
        smartcase = true;
        wildmode = "list:longest";
        swapfile = false;
        undofile = true; # Build-in persistent undo
        #termguicolors = lib.mkForce pkgs.stdenv.isLinux;
      };

      plugins = {
        # oil manage folders and files like buffers
        oil.enable = true;

        # auto closing parentheses and marks
        autoclose.enable = true;

        # comment out code
        comment.enable = true;

        # better status line
        lualine.enable = true;

        # Panel with hints
        trouble.enable = true;

        # show vim keys
        which-key.enable = true;

        # colorful braces
        rainbow-delimiters.enable = true;

        # Autocompletion
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              {name = "nvim_lsp";}
              {name = "path";}
              {name = "buffer";}
              {name = "luasnip";}
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-Esc>" = "cmp.mapping.close()";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i', 's'})";
              "<CR>" =
                # lua
                ''
                  function(fallback)
                    local line = vim.api.nvim_get_current_line()
                    if line:match("^%s*$") then
                      fallback()
                    elseif cmp.visible() then
                      cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                    else
                      fallback()
                    end
                  end
                '';
              "<Down>" =
                # lua
                ''
                  function(fallback)
                    if cmp.visible() then
                      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    elseif require("luasnip").expand_or_jumpable() then
                      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                    else
                      fallback()
                    end
                  end
                '';
              "<Up>" =
                # lua
                ''
                  function(fallback)
                    if cmp.visible() then
                      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    elseif require("luasnip").jumpable(-1) then
                      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                    else
                      fallback()
                    end
                  end
                '';
            };
          };
        };

        # icons
        mini = {
          enable = true;
          modules.icons = {};
          mockDevIcons = true;
        };

        # fuzzy finder
        telescope = {
          enable = true;
          extensions.fzf-native = {enable = true;};
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<C-p>" = {
              action = "git_files";
              options = {
                desc = "Telescope Git Files";
              };
            };
          };
        };

        # better sytax highlighting
        treesitter = {
          enable = true;

          nixGrammars = true;

          settings = {
            highlight.enable = true;
            indent.enable = true;
          };

          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            json
            markdown
            nix
          ];
        };

        treesitter-context = {
          enable = true;
          settings = {max_lines = 2;};
        };

        # git helpers
        gitsigns = {
          enable = true;
          settings = {
            current_line_blame = true;
            trouble = true;
          };
        };

        # formating
        none-ls = {
          enable = true;
          sources = {
            formatting = {
              alejandra.enable = true;
              # prettier = {
              #   enable = true;
              #   disableTsServerFormatter = true;
              # };
              # markdownlint.enable = true;
            };
          };
        };

        # Lange Server Protocolls
        lsp = {
          enable = true;
          inlayHints = true;
          keymaps.lspBuf = {
            "gd" = "definition";
            "gD" = "references";
            "gt" = "type_definition";
            "gi" = "implementation";
            "<leader>rn" = "rename";
            "K" = "hover";
          };

          servers = {
            ts_ls.enable = true;

            angularls = {
              enable = true;
            };

            rust_analyzer = {
              enable = true;
              installRustc = false;
              installCargo = false;
              installRustfmt = true;
            };
          };
        };

        # Format code over LSPs
        lsp-format.enable = true;
      };
    };
  };
}
