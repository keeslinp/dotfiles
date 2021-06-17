local map = vim.api.nvim_set_keymap

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = { noremap = true, silent=true }
map('n', '<leader>p', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', options)
map('n', '<leader>s', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', options)
map('n', '<leader>a', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>]], options)
map('n', '<c-s>', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], options)
map('n', 'gr', [[<cmd>lua require'telescope.builtin'.lsp_references()<cr>]], options)
map('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], options)
map('n', '<leader>g', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], options)

map("n", "<leader>cc", "<Plug>kommentary_line_default", {})
map("v", "<leader>cc", "<Plug>kommentary_visual_default", {})
map('n', '<c-l>', '<c-w>l', {})
map('n', '<c-h>', '<c-w>h', {})
map('n', '<c-n>', '<cmd>NvimTreeToggle<cr>', {})
map('t', '<esc>', '<c-\\><c-n>', {})

map('n', 'gb', '<cmd>Git blame_line<cr>', {})
