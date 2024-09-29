return {
  "nvim-java/nvim-java",
  event = "VeryLazy",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        setup = {
          jdtls = function()
            require("java").setup({
              -- Your custom nvim-java configuration goes here
            })
          end,
        },
        servers = {
          jdtls = {
            -- Your custom jdtls settings goes here
          },
        },
      },
    },
  },
}
