vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- save the file
keymap.set("n", "<C-s>", ":w<CR>", { desc = "save file" })
keymap.set("i", "<C-s>", "<ESC> :w<CR>", { desc = "exit insert mode and save file" })

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Flutter-specific keymaps
keymap.set("n", "<leader>ur", "<cmd>FlutterRun<CR>", { desc = "Flutter Run" })
keymap.set("n", "<leader>uq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
keymap.set("n", "<leader>ur", "<cmd>FlutterReload<CR>", { desc = "Flutter Hot Reload" })
keymap.set("n", "<leader>uR", "<cmd>FlutterRestart<CR>", { desc = "Flutter Hot Restart" })
keymap.set("n", "<leader>uD", "<cmd>FlutterVisualDebug<CR>", { desc = "Flutter Visual Debug" })
keymap.set("n", "<leader>ud", "<cmd>FlutterDevices<CR>", { desc = "Flutter Devices" })
keymap.set("n", "<leader>ue", "<cmd>FlutterEmulators<CR>", { desc = "Flutter Emulators" })
keymap.set("n", "<leader>uc", "<cmd>FlutterLogClear<CR>", { desc = "Flutter Log Clear" })
keymap.set("n", "<leader>uo", "<cmd>FlutterOutline<CR>", { desc = "Flutter Outline" })
keymap.set("n", "<leader>us", "<cmd>FlutterScreenshot<CR>", { desc = "Flutter Screenshot" })
keymap.set("n", "<leader>ul", "<cmd>FlutterLspRestart<CR>", { desc = "Restart Flutter LSP" })

-- Dart-specific keymaps
keymap.set("n", "<leader>md", "<cmd>DartFmt<CR>", { desc = "Dart Format" })
