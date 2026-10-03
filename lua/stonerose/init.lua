local p = require("stonerose.palette")
local M = {}

-- Neovim highlights need opaque RGB, so composite Zed's alpha over the editor.
local function blend(color, alpha, background)
  background = background or p.bg
  local channels = {}
  for offset = 2, 6, 2 do
    local front = tonumber(color:sub(offset, offset + 1), 16)
    local back = tonumber(background:sub(offset, offset + 1), 16)
    channels[#channels + 1] = math.floor(front * alpha + back * (1 - alpha) + 0.5)
  end
  return string.format("#%02X%02X%02X", unpack(channels))
end

---Apply StoneRose's highlights and terminal palette.
---Use `:colorscheme stonerose` to also notify plugins through ColorScheme.
function M.load()
  vim.opt.background = "dark"
  vim.opt.termguicolors = true
  vim.cmd("highlight clear")
  vim.g.colors_name = "stonerose"

  local groups = {
    Normal = { fg = p.fg, bg = p.bg },
    NormalNC = { fg = p.fg, bg = p.bg },
    NormalFloat = { fg = p.text, bg = p.surface },
    FloatBorder = { fg = p.border, bg = p.surface },
    FloatTitle = { fg = p.blue, bg = p.surface },
    FloatFooter = { fg = p.muted, bg = p.surface },
    Cursor = { fg = p.bg, bg = p.blue },
    CursorLine = { bg = blend(p.surface, 191 / 255) },
    CursorColumn = { bg = blend(p.surface, 191 / 255) },
    ColorColumn = { bg = p.surface },
    LineNr = { fg = p.comment },
    CursorLineNr = { fg = p.muted },
    SignColumn = { bg = p.bg },
    FoldColumn = { fg = p.comment, bg = p.bg },
    Folded = { fg = p.muted, bg = p.surface },
    EndOfBuffer = { fg = p.border },
    NonText = { fg = p.comment },
    Whitespace = { fg = p.comment },
    Conceal = { fg = p.comment },
    WinSeparator = { fg = p.border },
    StatusLine = { fg = p.text, bg = p.bg },
    StatusLineNC = { fg = p.muted, bg = p.bg },
    WinBar = { fg = p.text, bg = p.bg },
    WinBarNC = { fg = p.muted, bg = p.bg },
    TabLine = { fg = p.muted, bg = p.bg },
    TabLineFill = { bg = p.bg },
    TabLineSel = { fg = p.text, bg = p.surface },
    Pmenu = { fg = p.text, bg = p.surface },
    PmenuSel = { fg = p.text, bg = blend(p.border, 160 / 255, p.surface) },
    PmenuSbar = { bg = p.surface },
    PmenuThumb = { bg = p.border },
    PmenuMatch = { fg = p.blue, bold = true },
    PmenuMatchSel = { fg = p.blue, bold = true },
    Visual = { bg = blend(p.blue, 61 / 255) },
    Search = { bg = blend(p.pink, 111 / 255) },
    IncSearch = { fg = p.bg, bg = p.pink },
    CurSearch = { fg = p.bg, bg = p.pink },
    Substitute = { fg = p.bg, bg = p.red },
    MatchParen = { bg = p.border },
    QuickFixLine = { bg = p.surface },
    Directory = { fg = p.blue },
    Title = { fg = p.yellow },
    Question = { fg = p.blue },
    MoreMsg = { fg = p.cyan },
    ModeMsg = { fg = p.text },
    MsgArea = { fg = p.fg, bg = p.bg },
    MsgSeparator = { fg = p.border, bg = p.bg },
    ErrorMsg = { fg = p.red },
    WarningMsg = { fg = p.yellow },
    OkMsg = { fg = p.green },
    DiffAdd = { bg = blend(p.green, 26 / 255) },
    DiffChange = { bg = blend(p.purple, 26 / 255) },
    DiffDelete = { fg = p.red, bg = blend(p.red, 26 / 255) },
    DiffText = { bg = blend(p.purple, 68 / 255) },
    Added = { fg = p.green },
    Changed = { fg = p.purple },
    Removed = { fg = p.red },
    Comment = { fg = p.comment, italic = true },
    Constant = { fg = p.yellow },
    String = { fg = p.green },
    Character = { fg = p.green },
    Number = { fg = p.yellow },
    Boolean = { fg = p.yellow },
    Float = { fg = p.yellow },
    Identifier = { fg = p.fg },
    Function = { fg = p.blue },
    Statement = { fg = p.purple },
    PreProc = { fg = p.purple },
    Type = { fg = p.pink },
    Special = { fg = p.cyan },
    Delimiter = { fg = p.fg },
    Operator = { fg = p.fg },
    Label = { fg = p.blue },
    Todo = { fg = p.yellow, bold = true },
    Error = { fg = p.red },
    Underlined = { fg = p.blue, underline = true },
    Ignore = { fg = p.comment },
    ["@variable.builtin"] = { fg = p.cyan },
    ["@module"] = { fg = p.pink },
    ["@attribute"] = { fg = p.yellow },
    ["@punctuation.special"] = { fg = p.purple },
    ["@markup.strong"] = { fg = p.yellow, bold = true },
    ["@markup.italic"] = { fg = p.purple, italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.link"] = { fg = p.blue, italic = true },
    ["@markup.link.url"] = { fg = p.cyan, underline = true },
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.typemod.variable.readonly"] = { fg = p.yellow },
    ["@lsp.typemod.property.readonly"] = { fg = p.yellow },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = p.cyan },
    LspReferenceText = { bg = blend(p.blue, 26 / 255) },
    LspReferenceRead = { bg = blend(p.blue, 26 / 255) },
    LspReferenceWrite = { bg = blend(p.border, 128 / 255) },
    LspInlayHint = { fg = p.comment },
    LspCodeLens = { fg = p.comment },
    SnippetTabstop = { bg = blend(p.blue, 26 / 255) },
  }

  local links = {
    lCursor = "Cursor",
    CursorIM = "Cursor",
    TermCursor = "Cursor",
    VisualNOS = "Visual",
    CursorLineSign = "SignColumn",
    CursorLineFold = "FoldColumn",
    StatusLineTerm = "StatusLine",
    StatusLineTermNC = "StatusLineNC",
    VertSplit = "WinSeparator",
    PmenuBorder = "FloatBorder",
    PmenuKind = "Type",
    PmenuKindSel = "Type",
    PmenuExtra = "Comment",
    PmenuExtraSel = "Comment",
    ComplMatchIns = "PmenuMatch",
    WildMenu = "PmenuSel",
    Conditional = "Statement",
    Repeat = "Statement",
    Keyword = "Statement",
    Exception = "Statement",
    Include = "PreProc",
    Define = "PreProc",
    Macro = "PreProc",
    PreCondit = "PreProc",
    StorageClass = "Type",
    Structure = "Type",
    Typedef = "Type",
    SpecialChar = "Special",
    SpecialComment = "Comment",
    Debug = "Special",
    Tag = "Identifier",
    ["@variable"] = "Identifier",
    ["@variable.parameter"] = "Identifier",
    ["@variable.parameter.builtin"] = "@variable.builtin",
    ["@variable.member"] = "Identifier",
    ["@constant"] = "Constant",
    ["@constant.builtin"] = "Constant",
    ["@constant.macro"] = "Constant",
    ["@module.builtin"] = "@module",
    ["@label"] = "Label",
    ["@string"] = "String",
    ["@string.documentation"] = "String",
    ["@string.regexp"] = "Special",
    ["@string.escape"] = "Special",
    ["@string.special"] = "Special",
    ["@string.special.symbol"] = "Special",
    ["@string.special.path"] = "Special",
    ["@string.special.url"] = "Special",
    ["@character"] = "Character",
    ["@character.special"] = "Special",
    ["@boolean"] = "Boolean",
    ["@number"] = "Number",
    ["@number.float"] = "Float",
    ["@type"] = "Type",
    ["@type.builtin"] = "Type",
    ["@type.definition"] = "Type",
    ["@attribute.builtin"] = "@attribute",
    ["@property"] = "Identifier",
    ["@function"] = "Function",
    ["@function.builtin"] = "Function",
    ["@function.call"] = "Function",
    ["@function.macro"] = "Function",
    ["@function.method"] = "Function",
    ["@function.method.call"] = "Function",
    ["@constructor"] = "Function",
    ["@operator"] = "Operator",
    ["@keyword"] = "Statement",
    ["@keyword.directive"] = "PreProc",
    ["@punctuation.delimiter"] = "Delimiter",
    ["@punctuation.bracket"] = "Delimiter",
    ["@comment"] = "Comment",
    ["@comment.documentation"] = "Comment",
    ["@comment.error"] = "DiagnosticError",
    ["@comment.warning"] = "DiagnosticWarn",
    ["@comment.todo"] = "Todo",
    ["@comment.note"] = "DiagnosticInfo",
    ["@markup.heading"] = "Title",
    ["@markup.quote"] = "Comment",
    ["@markup.math"] = "Special",
    ["@markup.link.label"] = "@markup.link",
    ["@markup.raw"] = "String",
    ["@markup.list"] = "Delimiter",
    ["@markup.list.checked"] = "Added",
    ["@markup.list.unchecked"] = "Todo",
    ["@diff.plus"] = "Added",
    ["@diff.minus"] = "Removed",
    ["@diff.delta"] = "Changed",
    ["@tag"] = "Identifier",
    ["@tag.builtin"] = "Identifier",
    ["@tag.attribute"] = "@attribute",
    ["@tag.delimiter"] = "Delimiter",
    ["@lsp.type.class"] = "@type",
    ["@lsp.type.comment"] = "@comment",
    ["@lsp.type.decorator"] = "@attribute",
    ["@lsp.type.enum"] = "@type",
    ["@lsp.type.enumMember"] = "@type",
    ["@lsp.type.event"] = "@type",
    ["@lsp.type.function"] = "@function",
    ["@lsp.type.interface"] = "@type",
    ["@lsp.type.keyword"] = "@keyword",
    ["@lsp.type.macro"] = "@function.macro",
    ["@lsp.type.method"] = "@function.method",
    ["@lsp.type.modifier"] = "@keyword",
    ["@lsp.type.namespace"] = "@module",
    ["@lsp.type.number"] = "@number",
    ["@lsp.type.operator"] = "@operator",
    ["@lsp.type.parameter"] = "@variable.parameter",
    ["@lsp.type.property"] = "@property",
    ["@lsp.type.regexp"] = "@string.regexp",
    ["@lsp.type.string"] = "@string",
    ["@lsp.type.struct"] = "@type",
    ["@lsp.type.type"] = "@type",
    ["@lsp.type.typeParameter"] = "@type",
    ["@lsp.type.variable"] = "@variable",
    LspReferenceTarget = "LspReferenceText",
    LspCodeLensSeparator = "LspCodeLens",
  }

  -- Explicit children override Neovim's default links to legacy syntax groups.
  for _, suffix in ipairs({
    "coroutine",
    "function",
    "import",
    "type",
    "modifier",
    "repeat",
    "return",
    "debug",
    "exception",
    "conditional",
    "conditional.ternary",
  }) do
    links["@keyword." .. suffix] = "Statement"
  end
  links["@keyword.operator"] = "Operator"
  links["@keyword.directive.define"] = "PreProc"
  for level = 1, 6 do
    links["@markup.heading." .. level] = "Title"
  end

  local diagnostic_colors = {
    Error = p.red,
    Warn = p.yellow,
    Info = p.cyan,
    Hint = p.comment,
    Ok = p.green,
  }
  for severity, color in pairs(diagnostic_colors) do
    groups["Diagnostic" .. severity] = { fg = color }
    groups["DiagnosticVirtualText" .. severity] = { fg = color, bg = blend(color, 26 / 255) }
    groups["DiagnosticUnderline" .. severity] = { sp = color, undercurl = true }
    links["DiagnosticSign" .. severity] = "Diagnostic" .. severity
    links["DiagnosticFloating" .. severity] = "Diagnostic" .. severity
    links["DiagnosticVirtualLines" .. severity] = "Diagnostic" .. severity
  end
  groups.SpellBad = { sp = p.red, undercurl = true }
  groups.SpellCap = { sp = p.yellow, undercurl = true }
  groups.SpellLocal = { sp = p.cyan, undercurl = true }
  groups.SpellRare = { sp = p.purple, undercurl = true }
  groups.DiagnosticDeprecated = { strikethrough = true }
  groups.DiagnosticUnnecessary = { fg = p.comment }

  for name, attrs in pairs(groups) do
    vim.api.nvim_set_hl(0, name, attrs)
  end
  for name, target in pairs(links) do
    vim.api.nvim_set_hl(0, name, { link = target })
  end
  require("stonerose.integrations").load()

  local terminal = {
    p.bg,
    p.red,
    p.green,
    p.yellow,
    p.blue,
    p.purple,
    p.cyan,
    p.fg,
    p.comment,
    p.red,
    p.green,
    p.yellow,
    p.blue,
    p.purple,
    p.cyan,
    p.bright,
  }
  for index, color in ipairs(terminal) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

return M
