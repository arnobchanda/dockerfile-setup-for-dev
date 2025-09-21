--- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Toggle Term
map("n", "<F7>", '<cmd>execute v:count . "ToggleTerm"<CR>', { desc = "Toggle Terminal" })
map("t", "<F7>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

vim.keymap.set("n", "<leader>gR", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    print("No file open!")
    return
  end

  local file_name = vim.fn.expand("%:t")
  local cmd = "git checkout HEAD -- " .. file
  print("Running: " .. cmd)

  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    print("Git error: " .. result)
  else
    vim.cmd("edit!")
    print("Reset file " .. file_name .. " to HEAD")
  end
end, { desc = "Reset current file to HEAD" })

-- Move line up
map("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move line down
map("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

--Code folding
map("n", "<leader>czf", "za", { desc = "Toggle Collapse function" })
map("n", "<leader>czo", "zR", { desc = "Open All folds" })
map("n", "<leader>czc", "zM", { desc = "Close All folds" })

-- Dont reach for escape key
map("i", "jj", "<Esc>", { noremap = true, silent = true })
map("i", "jk", "<Esc>", { noremap = true, silent = true })
