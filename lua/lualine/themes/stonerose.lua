local p = require("stonerose.palette")

local function mode(color)
  return {
    a = { fg = p.bg, bg = color, gui = "bold" },
    b = { fg = p.text, bg = p.surface },
    c = { fg = p.fg, bg = p.bg },
  }
end

return {
  normal = mode(p.blue),
  insert = mode(p.green),
  visual = mode(p.purple),
  replace = mode(p.red),
  command = mode(p.yellow),
  terminal = mode(p.cyan),
  inactive = {
    a = { fg = p.muted, bg = p.bg },
    b = { fg = p.muted, bg = p.bg },
    c = { fg = p.muted, bg = p.bg },
  },
}
