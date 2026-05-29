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

      keymaps = [
        # Show error in current line
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>lua vim.diagnostic.open_float()<CR>";
          options.desc = "Show Line Diagnostics";
        }
        # open trouble
        {
          mode = "n";
          key = "<leader>xx";
          action = "<cmd>Trouble diagnostics toggle<CR>";
          options.desc = "Diagnostics (Trouble)";
        }
        # From the current file to the folder on oil
        {
          mode = "n";
          key = "-";
          action = "<cmd>Oil<CR>";
          options.desc = "Open Parent Directory (Oil)";
        }
        # Toggle breakpoints
        {
          mode = "n";
          key = "<leader>db";
          action = "<cmd>DapToggleBreakpoint<CR>";
          options.desc = "Debug: Toggle Breakpoint";
        }
        # Start debugger or jump to next breakpoint
        {
          mode = "n";
          key = "<leader>dc";
          action = "<cmd>DapContinue<CR>";
          options.desc = "Debug: Start/Continue";
        }
        # Step in debugger
        {
          mode = "n";
          key = "<leader>do";
          action = "<cmd>DapStepOver<CR>";
          options.desc = "Debug: Step Over";
        }
        # Step in function
        {
          mode = "n";
          key = "<leader>di";
          action = "<cmd>DapStepInto<CR>";
          options.desc = "Debug: Step Into";
        }
        # Show hide debug window
        {
          mode = "n";
          key = "<leader>du";
          action = "<cmd>lua require('dapui').toggle()<CR>";
          options.desc = "Debug: Toggle UI";
        }
        # Git: preview changes
        {
          mode = "n";
          key = "<leader>gp";
          action = "<cmd>Gitsigns preview_hunk<CR>";
          options.desc = "Git: Preview Hunk";
        }
        # Git: reset changes
        {
          mode = "n";
          key = "<leader>gr";
          action = "<cmd>Gitsigns reset_hunk<CR>";
          options.desc = "Git: Reset Hunk";
        }
        # format code
        {
          mode = ["n" "v"];
          key = "<leader>rf"; # Refactor Format
          action.__raw = "function() require('conform').format({ async = true, lsp_fallback = true }) end";
          options.desc = "Refactor: Format Buffer";
        }
        # Neotest: Run nearest test to cursor
        {
          mode = "n";
          key = "<leader>tt"; # "rt" für Run Test (Nearest)
          action = "<cmd>lua require('neotest').run.run()<CR>";
          options.desc = "Test: Run Nearest";
        }
        # Neotest: Run test file
        {
          mode = "n";
          key = "<leader>tf"; # "rf" für Run File
          action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>";
          options.desc = "Test: Run Current File";
        }
        # Neotest: Show test UI
        {
          mode = "n";
          key = "<leader>ts"; # "ts" für Test Summary
          action = "<cmd>lua require('neotest').summary.toggle()<CR>";
          options.desc = "Test: Toggle Summary";
        }
        # Neotest: Show output of last test
        {
          mode = "n";
          key = "<leader>to";
          action = "<cmd>lua require('neotest').output.open({ enter = true })<CR>";
          options.desc = "Test: Show Output";
        }
        # Organize Imports
        {
          mode = "n";
          key = "<leader>oi"; # "oi" für Organize Imports
          action.__raw = ''
            function()
              vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports" } },
                apply = true,
              })
            end
          '';
          options.desc = "LSP: Organize Imports";
        }
        # restore last session
        {
          mode = "n";
          key = "<leader>qs"; # "q" für Quit/Session, "s" für Select/Start
          action.__raw = "function() require('persistence').load() end";
          options.desc = "Restore Session (Current Dir)";
        }
        # load last session
        {
          mode = "n";
          key = "<leader>ql";
          action.__raw = "function() require('persistence').load({ last = true }) end";
          options.desc = "Restore Last Session";
        }
      ];

      plugins = {
        # oil manage folders and files like buffers
        oil = {
          enable = true;
          settings = {
            view_options = {
              show_hidden = true;
            };
          };
        };

        # auto closing parentheses and marks
        autoclose.enable = true;

        # comment out code
        comment.enable = true;

        # better status line
        lualine.enable = true;

        luasnip.enable = true;

        # remembering files
        persistence.enable = true;

        # Premade snippets
        friendly-snippets.enable = true;

        # Panel with hints
        trouble = {
          enable = true;
          settings = {
            # Sendet fehlgeschlagene Tests direkt ins Trouble-Panel
            auto_preview = true;
          };
        };

        # show vim keys
        which-key = {
          enable = true;
          settings = {
            spec = [
              {
                __unkeyed-1 = "<leader>d";
                group = "Debug";
                icon = "🐛";
              }
              {
                __unkeyed-1 = "<leader>f";
                group = "Telescope / Find";
                icon = "🔍";
              }
              {
                __unkeyed-1 = "<leader>g";
                group = "Git";
                icon = "🌿";
              }
              {
                __unkeyed-1 = "<leader>r";
                group = "Refactoring";
                icon = "🔨";
              }
              {
                __unkeyed-1 = "<leader>t";
                group = "Test";
                icon = "🧪";
              }
              {
                __unkeyed-1 = "<leader>o";
                group = "Organize / LSP";
                icon = "🧹";
              }
            ];
          };
        };

        # colorful braces
        rainbow-delimiters.enable = true;

        # Autocompletion
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            # we actually want to type $
            snippet = {
              expand = ''
                function(args)
                  require('luasnip').lsp_expand(args.body)
                end
              '';
            };
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
          settings = {
            defaults = {
              # Ignore these folders
              file_ignore_patterns = [
                "^node_modules/"
                "^%.git/"
                # generated lock files
                "package%-lock%.json"
                "pnpm%-lock%.yaml"
                "yarn%.lock"
                # angular build
                "^dist/"
                "^%.angular/"
              ];

              # Parameters for live_grep (<leader>fg)
              vimgrep_arguments = [
                "rg"
                "--color=never"
                "--no-heading"
                "--with-filename"
                "--line-number"
                "--column"
                "--smart-case"
                "--hidden" # hidden folders like .storybook
              ];
            };

            pickers = {
              find_files = {
                hidden = true; # Show hidden files too
              };

              buffers = {
                mappings = {
                  # Insert mode delete buffer. Lua required to to hickups
                  i = {
                    "<C-d>" = {__raw = "require('telescope.actions').delete_buffer";};
                  };
                  # In normal mode
                  n = {
                    "<C-d>" = {__raw = "require('telescope.actions').delete_buffer";};
                    "d" = {__raw = "require('telescope.actions').delete_buffer";}; # deletes buffer in normal mode
                  };
                };
              };
            };
          };
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<C-p>" = "git_files";
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
            rust
            typescript
            scss
            javascript
            html
            css
            go
            gomod
            gosum
            gowork
          ];
        };

        treesitter-context = {
          enable = true;
          settings = {
            max_lines = 2;
          };
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
              prettier = {
                enable = true;
                disableTsServerFormatter = true;
              };
              # markdownlint.enable = true;
            };
          };
        };

        # modern more stable formating
        conform-nvim = {
          enable = true;
          settings = {
            format_on_save = {
              lsp_format = "fallback";
              timeout_ms = 1000;
            };
          };
        };

        toggleterm = {
          enable = true;
          settings = {
            # open terminal with Ctrl + t
            open_mapping = "[[<C-t>]]";

            # ("horizontal", "vertical" oder "float")
            direction = "float";

            float_opts = {
              border = "curved";
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
            "<leader>ca" = "code_action";
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

            gopls = {
              enable = true;
            };

            emmet_ls.enable = true;
            tailwindcss.enable = false;
          };
        };

        # DAP Debugger, firewall issues
        dap = {
          enable = false;

          signs = {
            dapBreakpoint = {
              text = "🔴";
              texthl = "DapBreakpoint";
            };
          };
        };

        dap-ui = {
          enable = false;
        };

        dap-go = {
          enable = false;
        };

        # test runner
        neotest = {
          enable = true;
          adapters = {
            # Go
            go.enable = false;
            # Vitest
            vitest.enable = false;
          };
        };
      };

      # Fängt Abstürze von nvim-cmp bei kaputten SCSS/LESS Snippets (wie $) ab
      extraConfigLua = ''
        local cmp_snippet = require('cmp.utils.snippet')
        local orig_parse = cmp_snippet.parse
        cmp_snippet.parse = function(self, input)
          local ok, ret = pcall(orig_parse, self, input)
          if ok then
            return ret
          end
          -- Wenn das Parsen fehlschlägt (z.B. bei kaputten $ Snippets),
          -- ignorieren wir es leise, anstatt einen Fehler zu werfen.
          return nil
        end
      '';
    };
  };
}
