local cmp = require('cmp')
local lspconfig = require('lspconfig')
local opts = { noremap=true, silent=true }

local servers = { 'gopls', 'rust_analyzer', 'tsserver', 'cssls', 'kotlin_language_server' }

vim.api.nvim_set_keymap('n', '[[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '[]', '<cmd>lua vim.diagnostic.setqflist({ workspace = true })<CR>', opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.buf.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

vim.o.completeopt = "menuone,noselect"

local cmp_sources = cmp.config.sources({
  { name = 'nvim_lsp' },
});

local cmp_mapping = {
  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ['<Tab>'] = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end,
  ['<S-Tab>'] = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end
}

cmp.setup {
  sources = cmp_sources,
  mapping = cmp_mapping,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  }
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      }
    }
  }
end
