require("sidekick").setup({
  cli = {
    win = {
      layout = "float",
      float = {
        width = 0.9,
        height = 0.9,
      },
    },
    mux = {
      backend = "tmux",
      enabled = true,
    },
  },
})
