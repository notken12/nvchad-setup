local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  print "no mason lspconfig"
  return {}
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  print "no lspconfig"
  return {}
end

local servers = mason_lspconfig.get_installed_servers()

local server_opts = {}
local dont_setup = {
  ["jdtls"] = true,
  ["rust_analyzer"] = true,
}

for _i, server in ipairs(servers) do
  if not dont_setup[server] then
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    if server == "rust_analyzer" then
      -- Initialize the LSP via rust-tools instead
      -- require("user.rusttools").setup()
      -- Only if standalone support is needed
    end

    local merged_opts = vim.tbl_deep_extend("force", server_opts[server] or {}, opts)
    lspconfig[server].setup(merged_opts)
  end
end


return { on_attach = on_attach, capabilities = capabilities }
