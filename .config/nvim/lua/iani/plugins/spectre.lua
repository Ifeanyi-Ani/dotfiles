return {
  "nvim-pack/nvim-spectre",
  lazy = true,
  keys = {
    {
      "<Leader>sr",
      "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
      desc = "Search current word",
    },
    {
      "<Leader>sr",
      "<cmd>lua require('spectre').open_visual()<CR>",
      mode = "v",
      desc = "Search current word",
    },
    {
      "<Leader>st",
      "<cmd>lua require('spectre').toggle()<CR>",
      desc = "Toggle Spectre",
    },
    {
      "<Leader>sf",
      "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
      desc = "Search on current file",
    },
  },
}
