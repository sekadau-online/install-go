#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "📦 Update & install dependencies..."
pkg update -y
pkg install -y git nodejs php composer curl unzip wget neovim

echo "📦 Install Packer.nvim (plugin manager)..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim || true

echo "📦 Install PHP intelephense (LSP for Laravel/PHP)..."
npm install -g intelephense

echo "📦 Install Vue/JS LSP (Volar)..."
npm install -g @volar/vue-language-server

echo "✅ Done! Now generating Neovim config..."
mkdir -p ~/.config/nvim/lua

cat > ~/.config/nvim/init.lua <<'EOF'
-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Load plugins with packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'jose-elias-alvarez/null-ls.nvim'
end)

-- Autocompletion setup
local cmp = require'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
}

-- LSP setup
local lspconfig = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- PHP (Laravel)
lspconfig.intelephense.setup {
  capabilities = capabilities,
}

-- Vue/JS
lspconfig.volar.setup {
  capabilities = capabilities,
}

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()
EOF

echo "✅ Installation complete!"
echo "👉 Jalankan nvim lalu ketik :PackerSync untuk install plugin"
