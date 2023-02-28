local cmp = require('cmp')
local lspkind = require('lspkind')
local types = require("cmp.types")
local str = require("cmp.utils.str")




cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    view = {
        -- Sets the most relevant autocomplete to be next to cursor
        entries = {name = 'custom', selection_order = 'near_cursor' }
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            with_text = false,
            format = function(entry, vim_item)
                local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"

                return kind
            end,
        })
    },
    mapping = {
        -- ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        -- ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        -- ['<cr>'] = cmp.mapping.confirm({ select = true }), -- accept currently selected item. set `select` to `false` to only confirm explicitly selected items
    },

    -- where autocomplete can be obtained from
    -- split into 2 groups to change preference
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        }, {
        { name = 'buffer' },
        { name = 'path' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
      }, {
      { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
      { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
      { name = 'path' }
  }, {
      { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Rust LSP
require('rust-tools').setup({
  server = {
      -- from https://github.com/simrat39/rust-tools.nvim
      capabilities = capabilities,
      -- on_attach = lsp_attach,
      on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
  },
  filetype = {"rs"}
})

-- C/C++ LSP
require('ccls').setup({
  lsp = {
      server = {
          name = "ccls",  -- String name

          root_dir = vim.fs.dirname(vim.fs.find({ "compile_commands.json", ".git"}, { upward = true })[1]),

      init_options = {
          index = {
              threads = 0;
          };

          clang = {
              excludeArgs = { "-frounding-math"};
          };
      },

      -- |> Fix diagnostics.
      flags = lsp_flags,
      -- |> Attach LSP keybindings & other crap.
      on_attach = aum_general_on_attach,
      -- |> Add nvim-cmp or snippet completion capabilities.
      capabilities = completion_capabilities,
      -- |> Activate custom handlers.
      handlers = aum_handler_config,
      },

  },
  filetypes = {"c", "cpp", "h", "hpp", "cu", "cxx"},
})

require('lspconfig')['pyright'].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  filetype = {"py"},
})
