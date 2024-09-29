local cmp = require("cmp")
return {

  cmp.setup({
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item(), -- Next suggestion
      ["<Tab>"] = cmp.mapping.select_next_item(), -- Also next suggestion
      ["<C-p>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
      ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Shift+Tab for previous suggestion
      --      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm the selection
      --      ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion manually
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
    }),
  }),
}
