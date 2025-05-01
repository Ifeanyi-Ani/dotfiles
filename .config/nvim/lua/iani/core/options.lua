-- Cache frequently accessed vim globals
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

-- Performance related settings
cmd("set noswapfile") -- Disable swap for better performance
opt.hidden = true -- Enable background buffers
-- opt.lazyredraw = true -- Don't redraw screen while executing macros
-- opt.updatetime = 50 -- Faster completion
-- opt.timeoutlen = 300 -- Faster key sequence completion
-- opt.ttimeoutlen = 10 -- Faster key response time
-- opt.redrawtime = 1500 -- Allow more time for loading syntax on large files

-- Disable netrw (use alternative file explorer for better performance)
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
-- g.netrw_liststyle = 3 -- Keep this if you still want to use netrw occasionally

-- Editor settings
opt.number = true
opt.relativenumber = true
opt.cursorline = true -- Highlight current line
-- opt.signcolumn = "yes" -- Prevent text shift

-- Tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.softtabstop = 2 -- Match tabstop
-- opt.expandtab = true -- Expand tab to spaces
-- opt.autoindent = true -- Copy indent from current line when starting new one
-- opt.smartindent = true -- Improve indentation
-- opt.wrap = false -- No line wrapping

-- Search settings
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- If you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = false -- Don't highlight all matches

-- Better colors
opt.termguicolors = true -- True color support

-- Improved window splitting
opt.splitright = true -- Split vertical window to the right
opt.splitbelow = true -- Split horizontal window to the bottom
opt.splitkeep = "screen" -- Maintain code view when splitting

-- System integration
opt.clipboard:append("unnamedplus") -- Use system clipboard
opt.mouse = "a" -- Enable mouse for all modes

-- File handling
-- opt.scrolloff = 10
-- opt.sidescrolloff = 10
opt.fileencoding = "utf-8" -- Use UTF-8 encoding
opt.writebackup = false -- Don't create backup before overwriting file
opt.undofile = true -- Enable persistent undo

-- Create undodir if it doesn't exist
local undodir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir

-- Better completion experience
opt.completeopt = "menu,menuone,noselect"

-- If ripgrep is available, use it for faster searching
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Faster syntax highlighting for large files
cmd("syntax sync minlines=256")
cmd("syntax sync maxlines=500")

-- File type specific indentation (faster than runtime detection)
cmd([[
  augroup FileTypeSpecificAutocommands
      autocmd!
      autocmd FileType javascript,typescript,json,yaml,html,css setlocal ts=2 sts=2 sw=2
      autocmd FileType python,rust,go setlocal ts=4 sts=4 sw=4
      autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  augroup END
]])
