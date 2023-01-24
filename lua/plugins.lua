local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here

    use({ "wbthomason/packer.nvim" })
    use({ "nvim-lua/plenary.nvim" }) -- Common utilities

    -- Colorschemes
    use({ "EdenEast/nightfox.nvim" }) -- Color scheme
    use({ "folke/tokyonight.nvim" }) -- Color scheme

    --use({ "nvim-lualine/lualine.nvim" }) -- Statusline
    use({
	    'nvim-lualine/lualine.nvim',
	    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })
    require('lualine').setup {
        options = { theme = 'gruvbox' }
    }
    use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
    use({ "kyazdani42/nvim-web-devicons" }) -- File icons
    use({ "akinsho/bufferline.nvim" })

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
    use({ "hrsh7th/cmp-buffer" }) -- buffer completions
    use({ "hrsh7th/cmp-path" }) -- path completions
    use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
    use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "onsails/lspkind-nvim" })

    -- snippets
    use({ "L3MON4D3/LuaSnip" }) --snippet engine

    -- LSP
    use({ "neovim/nvim-lspconfig" }) -- enable LSP
    use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
    --    use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
    use({ "glepnir/lspsaga.nvim" }) -- LSP UIs

    -- Formatter
    use({ "MunifTanjim/prettier.nvim" })

    -- Telescope
    use({ "nvim-telescope/telescope.nvim" })
    --  use({ "nvim-tree/nvim-web-devicons" })
    use({ "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require "telescope".load_extension("frecency")
        end,
        requires = { "kkharji/sqlite.lua" }
    })

    --  for k, v in pairs({
    --    ['<C-p>'] = [[]],
    --  }) do
    --    vim.api.nvim_set_keymap('', k, v, {})
    --  end

    -- Treesitter
    --    need to install tree-sitter-cli by 'cargo install tree-sitter-cli'
    use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })
    use({ "nvim-telescope/telescope-file-browser.nvim" })

    use({ "windwp/nvim-ts-autotag" })

    -- see. https://riq0h.jp/2022/10/21/150848/
    use({ "lukas-reineke/indent-blankline.nvim" }) -- indent
    use({ "j-hui/fidget.nvim" }) -- LSP anim
    use({ "ErichDonGubler/lsp_lines.nvim" }) -- LSP anim
    require('lsp_lines').setup()

    use({ "tversteeg/registers.nvim" }) -- show registers
    -- show registers by
    -- Call :Registers
    -- Press " in normal or visual mode
    -- Press CtrlR in insert mode
    require('registers').setup()

    use({ "kevinhwang91/nvim-hlslens" }) -- matched information
    -- Minimal config
    require('hlslens').setup()
    local kopts = { noremap = true, silent = true }

    vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
    vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
    vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hls:lens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

    vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

    use({ "lambdalisue/fern.vim" }) -- filer
    vim.api.nvim_set_keymap('n', 'gf', '<Cmd>Fern . -reveal=% -drawer -toggle -width=40<CR>', kopts)
    vim.api.nvim_set_keymap('n', 'gc', '<Cmd>Fern . -drawer -toggle -width=40<CR>', kopts)

    use({ "brglng/vim-im-select" })
    if os.getenv('WSL_DISTRO_NAME') then
	    -- WSL environment
	    vim.cmd("let g:im_select_default = 0")
	    vim.cmd("let g:im_select_get_im_cmd = ['zenhan']")
	    vim.cmd("let g:ImSelectSetImCmd = {key -> ['zenhan', key]}")
    elseif jit.os == "OSX" then
	    -- MACOS
	    vim.cmd("let g:im_select_default = 'com.google.inputmethod.Japanese.Roman'")
	    vim.cmd("let g:im_select_get_im_cmd = ['im-select']")
	    vim.cmd("let g:ImSelectSetImCmd = {key -> ['im-select', key]}")
    end

    use({ "IMOKURI/line-number-interval.nvim" })
    vim.cmd([[
    highlight HighlightudLineNr guifg=White ctermfg=3
    highlight DimLineNr guifg=Purple ctermfg=3
    ]])

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
