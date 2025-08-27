--------------------------------------------------------
-- Basic Settings
--------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

--------------------------------------------------------
-- Install plugins with packer
--------------------------------------------------------
require("packer").startup(function(use)
  use 'wbthomason/packer.nvim'        -- Packer
  use 'neovim/nvim-lspconfig'         -- LSP
  use 'hrsh7th/nvim-cmp'              -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'              -- Snippet engine
  use 'saadparwaiz1/cmp_luasnip'      -- Luasnip source for cmp
  use 'rafamadriz/friendly-snippets'  -- Predefined snippets
  use 'nvim-lua/plenary.nvim'         -- Dependency
end)

--------------------------------------------------------
-- Setup luasnip + custom snippets
--------------------------------------------------------
local luasnip = require("luasnip")

-- Load VSCode style snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Load custom Lua snippets (go.lua, php.lua, javascript.lua)
require("luasnip.loaders.from_lua").load({
  paths = "~/.config/nvim/snippets"
})

--------------------------------------------------------
-- Setup nvim-cmp (completion)
--------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

--------------------------------------------------------
-- Setup LSP servers
--------------------------------------------------------
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Go
lspconfig.gopls.setup({
  capabilities = capabilities,
})

-- PHP (Laravel / intelephense)
lspconfig.intelephense.setup({
  capabilities = capabilities,
})

-- JavaScript / TypeScript (volar untuk Vue)
lspconfig.tsserver.setup({
  capabilities = capabilities,
})

lspconfig.volar.setup({
  capabilities = capabilities,
})

-- Lua (untuk config Neovim sendiri)
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})
