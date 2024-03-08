print(vim.loop.cwd())
if vim.loop.cwd() == nil or vim.loop.cwd() == '/' or vim.loop.cwd() == '' then
  vim.api.nvim_set_current_dir(vim.fn.expand('$HOME'))
end

require "core"

pcall(require, 'custom')

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

vim.schedule(function()
  require "core.mappings"
end, 0)
