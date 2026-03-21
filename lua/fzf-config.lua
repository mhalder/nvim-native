require("fzf-lua").setup({
  grep = {
    rg_glob = true,
    glob_flag = "--iglob",
    glob_separator = "%s%-%-",
  },
})
