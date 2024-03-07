local M = {}

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return {}
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return {}
end

-- export on_attach & capabilities for custom lspconfigs
M.on_attach = function(client, bufnr)
  local utils = require "core.utils"
  local conf = require("nvconfig").ui.lsp

  -- semanticTokens
  if not conf.semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end

  if conf.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client, bufnr)
  end

  utils.load_mappings("lspconfig", { buffer = bufnr })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local server_opts = {
	["rust_analyzer"] = {
		checkOnSave = {
			allFeatures = true,
			overrideCommand = {
				"cargo",
				"clippy",
				"--workspace",
				"--message-format=json",
				"--all-targets",
				"--all-features",
			},
		},
	},
  ["lua_ls"] = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
}

local dont_setup = {
	["jdtls"] = true,
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require "nvchad.lsp"

  local servers = mason_lspconfig.get_installed_servers()
  for _i, server in ipairs(servers) do
    if not dont_setup[server] then
      local opts = {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
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
end

return M
