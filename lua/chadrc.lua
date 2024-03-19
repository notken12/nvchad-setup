---@type ChadrcConfig
local M = {}
-- local config = require("nvconfig").ui.statusline
-- local sep_style = config.separator_style
local sep_style = "default";
-- local utils = require "nvchad.stl.utils"

local default_sep_icons = {
  default = { left = "", right = "" },
  round = { left = "", right = "" },
  block = { left = "█", right = "█" },
  arrow = { left = "", right = "" },
}

local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

local sep_l = separators["left"]

M.ui = {
  theme = "everforest",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
  --
  nvdash = {
    load_on_startup = true,

    header = { "             neovim              " },
  },

  statusline = {
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "cursorpos", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      cursorpos = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        local r, c = unpack(pos)
        return r .. ':' .. c .. ' '
      end
    }
  }
}

return M
