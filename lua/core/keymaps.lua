-- Key mappings

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', { desc = 'Navigate to left window', noremap = true, silent = true })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Navigate to bottom window', noremap = true, silent = true })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Navigate to top window', noremap = true, silent = true })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Navigate to right window', noremap = true, silent = true })

-- Buffer navigation
keymap('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer', noremap = true, silent = true })
keymap('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer', noremap = true, silent = true })

-- Move text up and down in visual mode
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move text down', noremap = true, silent = true })
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move text up', noremap = true, silent = true })

-- Stay in indent mode
keymap('v', '<', '<gv', { desc = 'Unindent line and keep selection', noremap = true, silent = true })
keymap('v', '>', '>gv', { desc = 'Indent line and keep selection', noremap = true, silent = true })

-- Move text up and down in visual block mode
keymap('x', 'J', ":move '>+1<CR>gv-gv", { desc = 'Move block down', noremap = true, silent = true })
keymap('x', 'K', ":move '<-2<CR>gv-gv", { desc = 'Move block up', noremap = true, silent = true })
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", { desc = 'Move block down', noremap = true, silent = true })
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", { desc = 'Move block up', noremap = true, silent = true })

-- Better paste (don't replace register with deleted text)
keymap('v', 'p', '"_dP', { desc = 'Paste without replacing register', noremap = true, silent = true })

-- Clear search highlights
keymap('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlights', noremap = true, silent = true })

-- Split window
keymap('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })

-- Close buffer
keymap('n', '<S-q> ', ':bd<CR>', { desc = 'Close current buffer' })

-- Save file
keymap('n', '<C-s>', ':w<CR>', { desc = 'Save file', noremap = true, silent = true })
keymap('i', '<C-s>', '<Esc>:w<CR>', { desc = 'Save file', noremap = true, silent = true })

-- Escape terminal mode
keymap('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode', noremap = true, silent = true })

-- Navigate tabs
-- keymap('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab', noremap = true, silent = true })
-- keymap('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab', noremap = true, silent = true })
-- keymap('n', '<leader>tj', ':tabnext<CR>', { desc = 'Next tab', noremap = true, silent = true })
-- keymap('n', '<leader>tk', ':tabprevious<CR>', { desc = 'Previous tab', noremap = true, silent = true })