-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


-- lvim.transparent_window = true;

lvim.lsp.installer.setup.automatic_installation = true

vim.opt.relativenumber = true;

lvim.format_on_save = true;

lvim.keys.insert_mode['jk'] = '<esc>';
lvim.keys.insert_mode['kj'] = '<esc>';
lvim.keys.insert_mode['<a-bs>'] = '<c-w>';


lvim.keys.normal_mode['<c-s>'] = ':w<cr>';
lvim.keys.normal_mode['<m-w>'] = ':BufferLineCyclePrev<cr>';
lvim.keys.normal_mode['<m-e>'] = ':BufferLineCycleNext<cr>';

lvim.keys.normal_mode['ö'] = '%';
lvim.keys.visual_mode['ö'] = '%';

lvim.keys.normal_mode["J"] = ":lua vim.diagnostic.open_float()<cr>"

-- toggle spell checking (toggle with !)
lvim.keys.normal_mode["<leader>S"] = ":set spell!<cr>"

-- reopen the last closed buffer
lvim.keys.normal_mode["<leader>C"] = ":e #<cr>"

-- make gd go to the lsp definition
lvim.keys.normal_mode["gd"] = "<cmd>lua vim.lsp.buf.definition()<cr>"
-- and gr to go to the references
lvim.keys.normal_mode["gr"] = "<cmd>lua vim.lsp.buf.references()<cr>"

lvim.plugins = {
  {
    -- multiple cursors with <c-n>
    'mg979/vim-visual-multi'
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"

      vim.cmd([[
        function! s:TexFocusVim() abort
          silent execute "!open -a iTerm"
          redraw!
        endfunction

        augroup vimtex_event_focus
          au!
          au User VimtexEventViewReverse call s:TexFocusVim()
        augroup END
      ]])
    end
  },
  {
    -- material theme
    "marko-cerovac/material.nvim"
  },
  {
    -- code folding
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      -- default settings to enable
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- setup folding source: first lsp, then indent as fallback
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'lsp', 'indent' }
        end
      })

      -- remap keys for "fold all" and "unfold all"
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds" })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds" })
    end,
  },
  {
    "tpope/vim-surround"
  },

  { "rose-pine/neovim", name = "rose-pine" },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          accept_word = "c-l",
          accept_line = "<m-p>"
        }
      })
    end
  },
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "felipec/vim-sanegx",
    event = "BufRead",
  },
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^4', -- Recommended
  },
  {
    'mg979/vim-visual-multi',
    config = function()
      -- Set your custom key mappings here
      vim.cmd([[
                let g:VM_maps['Add Cursor Down']    = '<C-J>'
                let g:VM_maps['Add Cursor Up']      = '<C-K>'
                " Add other mappings as needed
            ]])
    end
  },
  {
    'folke/trouble.nvim',
    cmd = "Trouble",
    opts = {}
  },
  {
    'aznhe21/actions-preview.nvim',
    config = function()
      vim.keymap.set({ "v", "n" }, "<c-.>", require("actions-preview").code_actions)
    end,
  },
  "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          -- Require providers
          require("hover.providers.lsp")
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          -- require('hover.providers.dap')
          -- require('hover.providers.fold_preview')
          -- require('hover.providers.diagnostic')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = 'single'
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
          'LSP'
        },
        mouse_delay = 1000
      }

      -- Setup keymaps
      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
      vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end,
        { desc = "hover.nvim (previous source)" })
      vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end,
        { desc = "hover.nvim (next source)" })

      -- Mouse support
      vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
      vim.o.mousemoveevent = true
    end
  }
}

-- rust_analyzer
-- jdtls
-- are in the ftplugin folder, so they are manually configured
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer", "jdtls" })

lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>Trouble diagnostics<cr>", "trouble" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "document" },
  q = { "<cmd>Trouble quickfix<cr>", "quickfix" },
  l = { "<cmd>Trouble loclist<cr>", "loclist" },
  r = { "<cmd>Trouble lsp_references<cr>", "references" },
}

-- enabling ctrl-l in the terminal!
lvim.keys.term_mode["<C-l>"] = false

-- make gf work in the terminal
lvim.keys.term_mode["gf"] = false

-- scroll only one line at a time
vim.cmd([[set mousescroll=ver:1,hor:1]])

-- reverse scroll direction in the horizontal direction
vim.api.nvim_set_keymap('n', '<ScrollWheelRight>', '1zh', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<ScrollWheelLeft>', '1zl', { noremap = true, silent = true })

-- set the colorscheme
lvim.colorscheme = 'rose-pine-moon';
-- make the code lens a bit less vibrant
vim.api.nvim_set_hl(0, 'LspCodeLens', { fg = '#2A2A2A', bg = 'NONE' })

-- disable automatic comment continuation
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- Setup all the LSP servers that are currently not in the ftplugin folder
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({})
lspconfig.texlab.setup({})
lspconfig.jedi_language_server.setup({})
