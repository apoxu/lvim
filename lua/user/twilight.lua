local M = {}

M.config = function()
  local twilight = pcall(require, "twilight")
  twilight.setup{
    dimming = {
      alpha = 0.25, -- amount of dimming
      color = { "Normal", "#ffffff" },
    },
    context = 15,
    expand = {
      "function", 
      "method",
      "table",
      "if_statement",
    },
    exclude = {},
  }
end

return M
