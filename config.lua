-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


-- lvim.transparent_window = true;

lvim.format_on_save = true;

lvim.keys.insert_mode['jk'] = '<esc>';
lvim.keys.insert_mode['kj'] = '<esc>';
lvim.keys.insert_mode['<a-bs>'] = '<c-w>';


lvim.keys.normal_mode['<c-s>'] = ':w<cr>';
lvim.keys.normal_mode['<m-w>'] = ':BufferLineCyclePrev<cr>';
lvim.keys.normal_mode['<m-e>'] = ':BufferLineCycleNext<cr>';

lvim.keys.normal_mode['ö'] = '%';
lvim.keys.visual_mode['ö'] = '%';

lvim.keys.normal_mode['<cr>'] = '/';
lvim.keys.visual_mode['<cr>'] = '/';

lvim.keys.normal_mode["J"] = ":lua vim.diagnostic.open_float()<cr>"

-- toggle spell checking (toggle with !)
lvim.keys.normal_mode["<leader>S"] = ":set spell!<cr>"

-- reopen the last closed buffer
lvim.keys.normal_mode["<leader>C"] = ":e #<cr>"

lvim.plugins = {
  -- {
  --   "zbirenbaum/copilot.lua",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         accept_word = "c-l",
  --         accept_line = "<m-p>"
  --       }
  --     })
  --   end
  -- },
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^3', -- Recommended
    lazy = false,   -- This plugin is already lazy
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
    version = '^3', -- Recommended
  },
  {
    'mg979/vim-visual-multi'
  },
  {
    'ribru17/bamboo.nvim'
  },
  {
    'Mofiqul/dracula.nvim'
  },
  {
    'shaunsingh/nord.nvim'
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
  }
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>Trouble diagnostics<cr>", "trouble" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "document" },
  q = { "<cmd>Trouble quickfix<cr>", "quickfix" },
  l = { "<cmd>Trouble loclist<cr>", "loclist" },
  r = { "<cmd>Trouble lsp_references<cr>", "references" },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "hls" })
local nvim_lsp = require('lspconfig')
nvim_lsp.hls.setup {
  -- the output you get when runnning '/Users/hapqe/.ghcup/tmp/ghcup-ghc-9.8.2_cabal-3.10.3.0_hls-2.9.0.1' + your servers version!
  -- todo: get the current version of each program using ghcup, like vscode does it as seen in vscode's extension log.
  cmd = { "/Users/hapqe/.ghcup/tmp/ghcup-ghc-9.8.2_cabal-3.10.3.0_hls-2.9.0.1/haskell-language-server-9.8.2", "--lsp" },
  on_attach = function(client, bufnr)
    -- Keybindings and other configurations
    -- Example keybinding:
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap = true, silent = true }

    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

    -- Keybinding: Show hover documentation with Shift+K
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end,
  settings = {
    haskell = {
      formattingProvider = "ormolu",
    }
  }
}

-- enabling ctrl-l in the terminal!
lvim.keys.term_mode["<C-l>"] = false
lvim.keys.term_mode["gf"] = false
