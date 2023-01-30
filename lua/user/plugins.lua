local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "1c7e3e6b0f4dd5a174fcea9fda8a4d7de593b826" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs", commit = "03580d758231956d33c8dd91e2be195106a79fa4" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "a0f89563ba36b3bacd62cf967b46beb4c2c29e52" }
  use { "nvim-tree/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" }
  use { "nvim-tree/nvim-tree.lua", commit = "9e87ee2d6e86f37ff09cb74ec7dcf2ac984a01e9" }
  use { "akinsho/bufferline.nvim", commit = "4ecfa81e470a589e74adcde3d5bb1727dd407363" }
  use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  use { "nvim-lualine/lualine.nvim", commit = "0050b308552e45f7128f399886c86afefc3eb988" }
  use { "akinsho/toggleterm.nvim", commit = "a54e6c471ce1cd8ef8357e34598a28a955297131" }
  use { "ahmedkhalf/project.nvim", commit = "685bc8e3890d2feb07ccf919522c97f7d33b94e4" }
  use { "lewis6991/impatient.nvim", commit = "227d02b37c56d9a8f6456b1017d04d7dc99076d5" }
  use { "lukas-reineke/indent-blankline.nvim", commit = "8299fe7703dfff4b1752aeed271c3b95281a952d" }
  use { "goolord/alpha-nvim", commit = "21a0f2520ad3a7c32c0822f943368dc063a569fb" }
  use { "folke/todo-comments.nvim", commit="74c7d28cb50b0713c881ef69bcb6cdd77d8907d1" }

  -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "affb21a81e6d7de073378eb86d02864c594104d9" }
  use { "lunarvim/darkplus.nvim", commit = "1826879d9cb14e5d93cd142d19f02b23840408a6" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", commit = "11a95792a5be0f5a40bab5fc5b670e5b1399a939" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" } -- path completions
  use { "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" }
  use { "hrsh7th/cmp-nvim-lua", commit = "f3491638d123cfd2c8048aefaf66d246ff250ca6" }

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "60bb423229c5a3df6e3c1acda9c7b4e70d589d78" } --snippet engine
  use { "rafamadriz/friendly-snippets", commit = "a6f7a1609addb4e57daa6bedc300f77f8d225ab7" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "1d3203b4c39ea5ec63cf1271d9e3b14a91706897" } -- enable LSP
  use { "williamboman/mason.nvim", commit = "621730a9911ff7544e6aab5570748c342ba8b1f7"}
  use { "williamboman/mason-lspconfig.nvim", commit = "422b9745143150e16cd3fe331c74f6737de75e72" }
  use { "jose-elias-alvarez/null-ls.nvim", commit = "d09d7d82cc26d63673cef85cb62895dd68aab6d8" } -- for formatters and linters
  use { "RRethy/vim-illuminate", commit = "4e1d43cdc39e35f495c7b39a78a349b4d5badad0"}

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "dce1156ca103b8222e4abbfc63f9c6887abf5ec6" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", commit = "6ae94e0341bead5bc00c4d14396fb7fd28629d3a" }

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "c52162b7b34a21bdc476425a4ab562c2f7bf1bb1" }

  -- DAP
  use { "mfussenegger/nvim-dap", commit = "c64a6627bb01eb151da96b28091797beaac09536" }
  use { "rcarriga/nvim-dap-ui", commit = "b3b977095877e8acc1ff236cffc81b5331619493" }
  use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

  -- Which Key
  -- use { "folke/which-key.nvim", commit = "8682d3003595017cd8ffb4c860a07576647cc6f8" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
