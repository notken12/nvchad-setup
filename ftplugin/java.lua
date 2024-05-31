local jdtls_config = require("configs.jdtls").setup()
local pkg_status, jdtls = pcall(require, "jdtls")
if not pkg_status then
  vim.notify("unable to load nvim-jdtls", "error")
  return
end
require('dap')
jdtls.start_or_attach(jdtls_config)
-- print(vim.inspect(jdtls_config.init_options))
