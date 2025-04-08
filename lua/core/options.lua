-- Core Neovim options

local opt = vim.opt

-- General settings
opt.mouse = 'a'                           -- Enable mouse support
opt.clipboard = 'unnamedplus'             -- Use system clipboard
opt.swapfile = false                      -- Don't use swapfile
opt.completeopt = 'menuone,noselect'      -- Better completion experience
opt.ignorecase = true                     -- Ignore case when searching
opt.smartcase = true                      -- Don't ignore case with capitals
opt.updatetime = 250                      -- Faster completion
opt.timeoutlen = 300                      -- Time to wait for a mapped sequence
opt.splitbelow = true                     -- Put new windows below current
opt.splitright = true                     -- Put new windows right of current

-- UI settings
opt.number = true                         -- Show line numbers
opt.relativenumber = true                 -- Show relative line numbers
opt.signcolumn = 'yes'                    -- Always show the signcolumn
opt.cursorline = true                     -- Highlight the current line
opt.showmode = false                      -- Dont show mode since we have a statusline
opt.scrolloff = 8                         -- Lines of context
opt.sidescrolloff = 8                     -- Columns of context
opt.wrap = true                          -- Display long lines as just one line
opt.linebreak = true                      -- Wrap on word boundaries
opt.showbreak = '↪'                       -- Show this when line is wrapped

-- Tabs, indent
opt.expandtab = true                      -- Use spaces instead of tabs
opt.shiftwidth = 2                        -- Size of an indent
opt.tabstop = 2                           -- Number of spaces tabs count for
opt.softtabstop = 2                       -- Number of spaces that a <Tab> counts for
opt.smartindent = true                    -- Insert indents automatically

-- Files
opt.fileencoding = 'utf-8'                -- File content encoding
opt.backup = false                        -- Don't store backup
opt.undofile = true                       -- Enable persistent undo
opt.hidden = true                         -- Enable background buffers

-- Search
opt.hlsearch = true                       -- Highlight search results
opt.incsearch = true                      -- Searches as you type

-- Display
opt.termguicolors = true                  -- True color support
opt.laststatus = 3                        -- Global statusline