diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}, require("mason").setup()
require("mason-lspconfig").setup()
--local capabilities=vim.lsp.protocol.make_client_capabilities()
--capabilities=require("cmp_nvim_lsp").update_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
)
-- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration=false
vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>")

require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            vim.diagnostic.config({
                underline = false,
                virtual_text = true,
            }),

            on_attach = function(_, buffer)
            end,
            capabilities = capabilities,
        })
    end,

    -- ["rust_analyzer"] = function()
    --     require("rust-tools").setup {}
    -- end
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["tsserver"] = function()
    --   local lspconfig = require("lspconfig")
    --   capabilities.documentFormattingProvider=false
    --   capabilities=capabilities
    --   lspconfig.tsserver.setup{}
    --   --   settings = {
    --   --     Lua = {
    --   --       diagnostics = {
    --   --         globals = { "vim" }
    --   --       }
    --   --     }
    --   --   }
    --   -- }
    --
    -- end,
})

for name, icon in pairs(diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>")
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
end)
vim.keymap.set("n", "gI", function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
end)
vim.keymap.set("n", "gy", function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
end)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help)
