local p = require("stonerose.palette")
local M = {}

---Apply plugin highlights without loading or requiring the plugins themselves.
function M.load()
  local groups = {
    BlinkCmpLabel = { fg = p.text },
    BlinkCmpLabelMatch = { fg = p.blue, bold = true },
    BlinkCmpLabelDeprecated = { fg = p.comment, strikethrough = true },
    BlinkCmpGhostText = { fg = p.border, italic = true },
    SnacksIndent = { fg = p.comment },
    SnacksIndentScope = { fg = p.muted },
    SnacksIndentChunk = { fg = p.muted },
    SnacksPickerMatch = { fg = p.blue, bold = true },
    SnacksPickerFile = { fg = p.fg },
    TroubleText = { fg = p.fg },
    LazyH1 = { fg = p.bg, bg = p.blue, bold = true },
    LazyButton = { fg = p.text, bg = p.surface },
    LazyButtonActive = { fg = p.bg, bg = p.blue },
    MasonHeader = { fg = p.bg, bg = p.blue, bold = true },
    MasonHeaderSecondary = { fg = p.bg, bg = p.purple, bold = true },
    FlashLabel = { fg = p.bg, bg = p.pink, bold = true },
  }

  -- Bufferline otherwise derives shades; explicit state colors retain Zed's surfaces.
  for _, state in ipairs({ "", "Visible", "Selected" }) do
    local bg = state == "Selected" and p.surface or p.bg
    local fg = state == "Selected" and p.text or (state == "Visible" and p.fg or p.muted)
    for _, part in ipairs({ "Buffer", "Numbers", "CloseButton" }) do
      groups["BufferLine" .. part .. state] = { fg = fg, bg = bg }
    end
    groups["BufferLineSeparator" .. state] = { fg = p.border, bg = bg }
    groups["BufferLineModified" .. state] = { fg = p.yellow, bg = bg }
    groups["BufferLineDiagnostic" .. state] = { fg = fg, bg = bg }
    for severity, color in pairs({ Error = p.red, Warning = p.yellow, Info = p.cyan, Hint = p.comment }) do
      groups["BufferLine" .. severity .. state] = { fg = color, bg = bg }
      groups["BufferLine" .. severity .. "Diagnostic" .. state] = { fg = color, bg = bg }
    end
  end
  groups.BufferLineFill = { bg = p.bg }
  groups.BufferLineBackground = { fg = p.muted, bg = p.bg }
  groups.BufferLineIndicatorSelected = { fg = p.blue, bg = p.surface }
  groups.BufferLineIndicatorVisible = { fg = p.border, bg = p.bg }
  groups.BufferLineTab = { fg = p.muted, bg = p.bg }
  groups.BufferLineTabSelected = { fg = p.text, bg = p.surface }
  groups.BufferLineTabClose = { fg = p.muted, bg = p.bg }
  groups.BufferLineOffsetSeparator = { fg = p.border, bg = p.bg }

  local links = {
    BlinkCmpMenu = "Pmenu",
    BlinkCmpMenuBorder = "FloatBorder",
    BlinkCmpMenuSelection = "PmenuSel",
    BlinkCmpLabelDetail = "Comment",
    BlinkCmpLabelDescription = "Comment",
    BlinkCmpKind = "Type",
    BlinkCmpDoc = "NormalFloat",
    BlinkCmpDocBorder = "FloatBorder",
    BlinkCmpDocSeparator = "WinSeparator",
    BlinkCmpDocCursorLine = "CursorLine",
    BlinkCmpSignatureHelp = "NormalFloat",
    BlinkCmpSignatureHelpBorder = "FloatBorder",
    BlinkCmpSignatureHelpActiveParameter = "Visual",
    GitSignsAdd = "Added",
    GitSignsChange = "Changed",
    GitSignsDelete = "Removed",
    GitSignsChangedelete = "Removed",
    GitSignsTopdelete = "Removed",
    GitSignsUntracked = "Added",
    GitSignsAddLn = "DiffAdd",
    GitSignsChangeLn = "DiffChange",
    GitSignsDeleteLn = "DiffDelete",
    GitSignsAddPreview = "DiffAdd",
    GitSignsDeletePreview = "DiffDelete",
    GitSignsCurrentLineBlame = "Comment",
    WhichKey = "Function",
    WhichKeyGroup = "Keyword",
    WhichKeyDesc = "Identifier",
    WhichKeySeparator = "Comment",
    WhichKeyValue = "Comment",
    WhichKeyNormal = "NormalFloat",
    WhichKeyBorder = "FloatBorder",
    WhichKeyTitle = "FloatTitle",
    WhichKeyIcon = "Function",
    NoiceCmdlinePopup = "NormalFloat",
    NoiceCmdlinePopupBorder = "FloatBorder",
    NoiceCmdlinePopupTitle = "FloatTitle",
    NoiceCmdlineIcon = "Function",
    NoiceCmdlineIconSearch = "Title",
    NoicePopup = "NormalFloat",
    NoicePopupBorder = "FloatBorder",
    NoicePopupmenu = "Pmenu",
    NoicePopupmenuMatch = "PmenuMatch",
    NoicePopupmenuSelected = "PmenuSel",
    NoiceLspProgressSpinner = "Function",
    NoiceLspProgressTitle = "Identifier",
    NoiceLspProgressClient = "Comment",
    TroubleNormal = "NormalFloat",
    TroubleNormalNC = "NormalFloat",
    TroubleFilename = "Directory",
    TroubleBasename = "Directory",
    TroubleDirectory = "Comment",
    TroubleSource = "Comment",
    TroubleCode = "Special",
    TroublePos = "LineNr",
    TroubleIndent = "LineNr",
    TroubleCount = "Title",
    TroublePreview = "Visual",
    SnacksNormal = "NormalFloat",
    SnacksWinBar = "WinBar",
    SnacksBackdrop = "Normal",
    SnacksDashboardNormal = "Normal",
    SnacksDashboardHeader = "Function",
    SnacksDashboardFooter = "Comment",
    SnacksDashboardTitle = "Title",
    SnacksDashboardDesc = "Identifier",
    SnacksDashboardIcon = "Function",
    SnacksDashboardKey = "Constant",
    SnacksDashboardFile = "Identifier",
    SnacksDashboardDir = "Comment",
    SnacksPicker = "NormalFloat",
    SnacksPickerBorder = "FloatBorder",
    SnacksPickerTitle = "FloatTitle",
    SnacksPickerInput = "NormalFloat",
    SnacksPickerInputBorder = "FloatBorder",
    SnacksPickerInputTitle = "FloatTitle",
    SnacksPickerPrompt = "Function",
    SnacksPickerSelected = "Constant",
    SnacksPickerDir = "Comment",
    SnacksPickerListCursorLine = "Visual",
    SnacksPickerPreviewCursorLine = "CursorLine",
    SnacksNotifierInfo = "DiagnosticInfo",
    SnacksNotifierWarn = "DiagnosticWarn",
    SnacksNotifierError = "DiagnosticError",
    LazyNormal = "NormalFloat",
    LazyProgressDone = "Added",
    LazyProgressTodo = "Comment",
    LazySpecial = "Special",
    MasonNormal = "NormalFloat",
    MasonHighlight = "Function",
    MasonHighlightBlock = "LazyH1",
    MasonHighlightSecondary = "Keyword",
    MasonMuted = "Comment",
    FlashMatch = "Search",
    FlashCurrent = "IncSearch",
    FlashBackdrop = "Comment",
  }
  for name, color in pairs({
    Azure = p.blue,
    Blue = p.blue,
    Cyan = p.cyan,
    Green = p.green,
    Grey = p.muted,
    Orange = p.yellow,
    Purple = p.purple,
    Red = p.red,
    Yellow = p.yellow,
  }) do
    groups["MiniIcons" .. name] = { fg = color }
  end
  for name, attrs in pairs(groups) do
    vim.api.nvim_set_hl(0, name, attrs)
  end
  for name, target in pairs(links) do
    vim.api.nvim_set_hl(0, name, { link = target })
  end
end

return M
