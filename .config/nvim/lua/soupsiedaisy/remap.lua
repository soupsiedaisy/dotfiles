-- ALT+{h,j,k,l} to navigate windows
vim.keymap.set({ "t", "i" }, "<A-h>", "<C-\\><C-N><C-w>h", { noremap = true } )
vim.keymap.set({ "t", "i" }, "<A-j>", "<C-\\><C-N><C-w>j", { noremap = true } )
vim.keymap.set({ "t", "i" }, "<A-k>", "<C-\\><C-N><C-w>k", { noremap = true } )
vim.keymap.set({ "t", "i" }, "<A-l>", "<C-\\><C-N><C-w>l", { noremap = true } )
vim.keymap.set("n", "<A-h>", "<C-w>h", { noremap = true } )
vim.keymap.set("n", "<A-j>", "<C-w>j", { noremap = true } )
vim.keymap.set("n", "<A-k>", "<C-w>k", { noremap = true } )
vim.keymap.set("n", "<A-l>", "<C-w>l", { noremap = true } )

-- CTRL+` {`,h,j,k,l} to open terminal (a bit hacky, but preserves split config)
-- TODO review hacky-ness
vim.keymap.set("n", "<C-`>`", vim.cmd.terminal, { noremap = true } )
vim.keymap.set("n", "<C-`>h", function ()
  local cur = vim.o.splitright
  vim.o.splitright = false
  vim.cmd.vsplit()
  vim.cmd.terminal()
  vim.o.splitright = cur
end, { noremap = true } )
vim.keymap.set("n", "<C-`>j", function ()
  local cur = vim.o.splitbelow
  vim.o.splitbelow = true
  vim.cmd.split()
  vim.cmd.terminal()
  vim.o.splitbelow = cur
end, { noremap = true } )
vim.keymap.set("n", "<C-`>k", function ()
  local cur = vim.o.splitbelow
  vim.o.splitbelow = false
  vim.cmd.split()
  vim.cmd.terminal()
  vim.o.splitbelow = cur
end, { noremap = true } )
vim.keymap.set("n", "<C-`>l", function ()
  local cur = vim.o.splitright
  vim.o.splitright = true
  vim.cmd.vsplit()
  vim.cmd.terminal()
  vim.o.splitright = cur
end, { noremap = true } )

