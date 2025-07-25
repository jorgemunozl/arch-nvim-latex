-- LaTeX snippets for LuaSnip based on LaTeX Suite
-- Converted from Obsidian LaTeX Suite format

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

-- Helper function for math context
local function in_mathzone()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- Helper function for text context
local function in_text()
  return not in_mathzone()
end

-- Helper function to get current date
local function get_date()
  return os.date("%Y-%m-%d")
end

return {
  -- Math mode entry
  s({trig = ",l", snippetType = "autosnippet", condition = in_text},
    { t("$"), i(1), t("$") }
  ),
  
  s({trig = ".ñ", snippetType = "autosnippet", condition = in_text, wordTrig = true},
    { t({"$$", ""}), i(1), t({"", "$$"}) }
  ),
  
  s({trig = "beg", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\begin{<>}\n<>\n\\end{<>}", {i(1), i(2), rep(1)})
  ),

  -- Greek letters (autosnippets)
  s({trig = "@a", snippetType = "autosnippet", condition = in_mathzone}, t("\\alpha")),
  s({trig = "@b", snippetType = "autosnippet", condition = in_mathzone}, t("\\beta")),
  s({trig = "@g", snippetType = "autosnippet", condition = in_mathzone}, t("\\gamma")),
  s({trig = "@G", snippetType = "autosnippet", condition = in_mathzone}, t("\\Gamma")),
  s({trig = "@d", snippetType = "autosnippet", condition = in_mathzone}, t("\\delta")),
  s({trig = "@D", snippetType = "autosnippet", condition = in_mathzone}, t("\\Delta")),
  s({trig = "@p", snippetType = "autosnippet", condition = in_mathzone}, t("\\psi")),
  s({trig = "@P", snippetType = "autosnippet", condition = in_mathzone}, t("\\Psi")),
  s({trig = "@e", snippetType = "autosnippet", condition = in_mathzone}, t("\\epsilon")),
  s({trig = ":e", snippetType = "autosnippet", condition = in_mathzone}, t("\\varepsilon")),
  s({trig = "@z", snippetType = "autosnippet", condition = in_mathzone}, t("\\zeta")),
  s({trig = "@t", snippetType = "autosnippet", condition = in_mathzone}, t("\\theta")),
  s({trig = "vp", snippetType = "autosnippet", condition = in_mathzone}, t("\\varphi")),
  s({trig = "@T", snippetType = "autosnippet", condition = in_mathzone}, t("\\Theta")),
  s({trig = ":t", snippetType = "autosnippet", condition = in_mathzone}, t("\\vartheta")),
  s({trig = "@i", snippetType = "autosnippet", condition = in_mathzone}, t("\\iota")),
  s({trig = "@k", snippetType = "autosnippet", condition = in_mathzone}, t("\\kappa")),
  s({trig = "@l", snippetType = "autosnippet", condition = in_mathzone}, t("\\lambda")),
  s({trig = "@L", snippetType = "autosnippet", condition = in_mathzone}, t("\\Lambda")),
  s({trig = "@s", snippetType = "autosnippet", condition = in_mathzone}, t("\\sigma")),
  s({trig = "@S", snippetType = "autosnippet", condition = in_mathzone}, t("\\Sigma")),
  s({trig = "@u", snippetType = "autosnippet", condition = in_mathzone}, t("\\upsilon")),
  s({trig = "@U", snippetType = "autosnippet", condition = in_mathzone}, t("\\Upsilon")),
  s({trig = "@o", snippetType = "autosnippet", condition = in_mathzone}, t("\\omega")),
  s({trig = "@O", snippetType = "autosnippet", condition = in_mathzone}, t("\\Omega")),
  s({trig = "ome", snippetType = "autosnippet", condition = in_mathzone}, t("\\omega")),
  s({trig = "Ome", snippetType = "autosnippet", condition = in_mathzone}, t("\\Omega")),
  
  -- Binomial and text
  s({trig = "bino", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\binom{<>}{<>}", {i(1), i(2)})
  ),
  s({trig = "text", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\text{<>}<>", {i(1), i(2)})
  ),

  -- Basic operations
  s({trig = "cup", snippetType = "autosnippet", condition = in_mathzone}, t("\\cup")),
  s({trig = "cap", snippetType = "autosnippet", condition = in_mathzone}, t("\\cap")),
  s({trig = "en", snippetType = "autosnippet", condition = in_mathzone}, t("\\in")),
  s({trig = "sr", snippetType = "autosnippet", condition = in_mathzone}, t("^{2}")),
  s({trig = "cb", snippetType = "autosnippet", condition = in_mathzone}, t("^{3}")),
  s({trig = "ed", snippetType = "autosnippet", condition = in_mathzone},
    fmta("^{<>}<>", {i(1), i(2)})
  ),
  s({trig = "sts", snippetType = "autosnippet", condition = in_mathzone},
    fmta("_\\text{<>}", {i(1)})
  ),
  s({trig = "sq", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\sqrt{ <> }<>", {i(1), i(2)})
  ),
  s({trig = "fra", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\frac{<>}{<>}<>", {i(1), i(2), i(3)})
  ),
  s({trig = "dp", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\frac{\\partial <>}{\\partial <>}<>", {i(1), i(2), i(3)})
  ),
  s({trig = "ee", snippetType = "autosnippet", condition = in_mathzone},
    fmta("e^{ <> }<>", {i(1), i(2)})
  ),
  s({trig = "vers", snippetType = "autosnippet", condition = in_mathzone}, t("^{-1}")),
  s({trig = "conj", snippetType = "autosnippet", condition = in_mathzone}, t("^{*}")),
  s({trig = "Re", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathrm{Re}")),
  s({trig = "Im", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathrm{Im}")),
  s({trig = "bf", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\mathbf{<>}", {i(1)})
  ),
  s({trig = "rm", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\mathrm{<>}<>", {i(1), i(2)})
  ),

  -- Linear algebra
  s({trig = "trace", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathrm{Tr}")),
  s({trig = "transp", snippetType = "autosnippet", condition = in_mathzone}, t("^{T}")),

  -- More operations
  s({trig = "hat", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\hat{<>}<>", {i(1), i(2)})
  ),
  s({trig = "bar", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\bar{<>}<>", {i(1), i(2)})
  ),
  s({trig = "dot", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\dot{<>}<>", {i(1), i(2)})
  ),
  s({trig = "ddot", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\ddot{<>}<>", {i(1), i(2)})
  ),
  s({trig = "cdot", snippetType = "autosnippet", condition = in_mathzone}, t("\\cdot")),
  s({trig = "tilde", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\tilde{<>}<>", {i(1), i(2)})
  ),
  s({trig = "und", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\underline{<>}<>", {i(1), i(2)})
  ),
  s({trig = "overl", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\overline{<>}<>", {i(1), i(2)})
  ),
  s({trig = "overs", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\overset{<>}<>", {i(1), i(2)})
  ),
  s({trig = "vec", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\vec{<>}<>", {i(1), i(2)})
  ),
  s({trig = "sd", snippetType = "autosnippet", condition = in_mathzone}, t("\\cdots")),
  s({trig = "vd", snippetType = "autosnippet", condition = in_mathzone}, t("\\vdots")),
  s({trig = "id", snippetType = "autosnippet", condition = in_mathzone}, t("\\ddots")),

  -- Common variable subscripts
  s({trig = "xnn", snippetType = "autosnippet", condition = in_mathzone}, t("x_{n}")),
  s({trig = "xii", snippetType = "autosnippet", condition = in_mathzone}, t("x_{i}")),
  s({trig = "xjj", snippetType = "autosnippet", condition = in_mathzone}, t("x_{j}")),
  s({trig = "xp1", snippetType = "autosnippet", condition = in_mathzone}, t("x_{n+1}")),
  s({trig = "ynn", snippetType = "autosnippet", condition = in_mathzone}, t("y_{n}")),
  s({trig = "yii", snippetType = "autosnippet", condition = in_mathzone}, t("y_{i}")),
  s({trig = "yjj", snippetType = "autosnippet", condition = in_mathzone}, t("y_{j}")),

  -- Symbols
  s({trig = "ooo", snippetType = "autosnippet", condition = in_mathzone}, t("\\infty")),
  s({trig = "sum", snippetType = "autosnippet", condition = in_mathzone}, t("\\sum")),
  s({trig = "adinf", snippetType = "autosnippet", condition = in_mathzone}, t("\\sum_{k=0}^{\\infty}")),
  s({trig = "prod", snippetType = "autosnippet", condition = in_mathzone}, t("\\prod")),
  s({trig = "adit", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\sum_{<>}^{<>} <>", {i(1, "i=1"), i(2, "n"), i(3)})
  ),
  s({trig = "lim", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\lim_{ <> \\to <> } <>", {i(1, "n"), i(2, "\\infty"), i(3)})
  ),
  s({trig = "+-", snippetType = "autosnippet", condition = in_mathzone}, t("\\pm")),
  s({trig = "-+", snippetType = "autosnippet", condition = in_mathzone}, t("\\mp")),
  s({trig = "...", snippetType = "autosnippet", condition = in_mathzone}, t("\\dots")),
  s({trig = "del", snippetType = "autosnippet", condition = in_mathzone}, t("\\nabla")),
  s({trig = "xx", snippetType = "autosnippet", condition = in_mathzone}, t("\\times")),
  s({trig = "**", snippetType = "autosnippet", condition = in_mathzone}, t("\\cdot")),
  s({trig = "para", snippetType = "autosnippet", condition = in_mathzone}, t("\\parallel")),

  -- Comparisons and relations
  s({trig = "===", snippetType = "autosnippet", condition = in_mathzone}, t("\\equiv")),
  s({trig = "apro", snippetType = "autosnippet", condition = in_mathzone}, t("\\approx")),
  s({trig = "!=", snippetType = "autosnippet", condition = in_mathzone}, t("\\neq")),
  s({trig = ">=", snippetType = "autosnippet", condition = in_mathzone}, t("\\geq")),
  s({trig = "<=", snippetType = "autosnippet", condition = in_mathzone}, t("\\leq")),
  s({trig = ">>", snippetType = "autosnippet", condition = in_mathzone}, t("\\gg")),
  s({trig = "<<", snippetType = "autosnippet", condition = in_mathzone}, t("\\ll")),
  s({trig = "simm", snippetType = "autosnippet", condition = in_mathzone}, t("\\sim")),
  s({trig = "sim=", snippetType = "autosnippet", condition = in_mathzone}, t("\\simeq")),
  s({trig = "prop", snippetType = "autosnippet", condition = in_mathzone}, t("\\propto")),
  s({trig = "cong", snippetType = "autosnippet", condition = in_mathzone}, t("\\cong")),

  -- Arrows and logic
  s({trig = "<->", snippetType = "autosnippet", condition = in_mathzone}, t("\\leftrightarrow ")),
  s({trig = "->", snippetType = "autosnippet", condition = in_mathzone}, t("\\to")),
  s({trig = "!>", snippetType = "autosnippet", condition = in_mathzone}, t("\\mapsto")),
  s({trig = "=>", snippetType = "autosnippet", condition = in_mathzone}, t("\\implies")),
  s({trig = "=<", snippetType = "autosnippet", condition = in_mathzone}, t("\\impliedby")),
  s({trig = "and", snippetType = "autosnippet", condition = in_mathzone}, t("\\land")),
  s({trig = "orr", snippetType = "autosnippet", condition = in_mathzone}, t("\\lor")),
  s({trig = "inn", snippetType = "autosnippet", condition = in_mathzone}, t("\\in")),
  s({trig = "nin", snippetType = "autosnippet", condition = in_mathzone}, t("\\not\\in")),

  -- Sets
  s({trig = "sub=", snippetType = "autosnippet", condition = in_mathzone}, t("\\subseteq")),
  s({trig = "sup=", snippetType = "autosnippet", condition = in_mathzone}, t("\\supseteq")),
  s({trig = "eset", snippetType = "autosnippet", condition = in_mathzone}, t("\\emptyset")),
  s({trig = "set", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\{ <> \\}<>", {i(1), i(2)})
  ),
  s({trig = "ecsi", snippetType = "autosnippet", condition = in_mathzone}, t("\\exists")),
  s({trig = "necsi", snippetType = "autosnippet", condition = in_mathzone}, t("\\nexists")),

  -- Special fonts
  s({trig = "LL", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathcal{L}")),
  s({trig = "cal", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\mathcal{<>}<>", {i(1), i(2)})
  ),
  s({trig = "HH", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathcal{H}")),
  s({trig = "CC", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathbb{C}")),
  s({trig = "RR", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathbb{R}")),
  s({trig = "ZZ", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathbb{Z}")),
  s({trig = "MM", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathcal{M}")),
  s({trig = "NN", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathbb{N}")),
  s({trig = "KK", snippetType = "autosnippet", condition = in_mathzone}, t("\\mathbb{K}")),
  s({trig = "freak", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\mathfrak{<>}<>", {i(1), i(2)})
  ),
  s({trig = "scr", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\mathscr{<>}<>", {i(1), i(2)})
  ),
  s({trig = "bb", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\mathbb{<>}<>", {i(1), i(2)})
  ),

  -- Derivatives and integrals
  s({trig = "ddt", snippetType = "autosnippet", condition = in_mathzone}, t("\\frac{d}{dt} ")),
  s({trig = "ddy", snippetType = "autosnippet", condition = in_mathzone}, t("\\frac{dx}{dy} ")),
  s({trig = "dint", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\int_{<>}^{<>} <> \\, d<> <>", {i(1, "0"), i(2, "1"), i(3), i(4, "x"), i(5)})
  ),
  s({trig = "oint", snippetType = "autosnippet", condition = in_mathzone}, t("\\oint")),
  s({trig = "iint", snippetType = "autosnippet", condition = in_mathzone}, t("\\iint")),
  s({trig = "iiint", snippetType = "autosnippet", condition = in_mathzone}, t("\\iiint")),
  s({trig = "oinf", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\int_{0}^{\\infty} <> \\, d<> <>", {i(1), i(2, "x"), i(3)})
  ),
  s({trig = "infi", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\int_{-\\infty}^{\\infty} <> \\, d<> <>", {i(1), i(2, "x"), i(3)})
  ),

  -- Environments
  s({trig = "pmat"},
    fmta("\\begin{pmatrix}\n<>\n\\end{pmatrix}", {i(1)})
  ),
  s({trig = "bmat"},
    fmta("\\begin{bmatrix}\n<>\n\\end{bmatrix}", {i(1)})
  ),
  s({trig = "Bmat"},
    fmta("\\begin{Bmatrix}\n<>\n\\end{Bmatrix}", {i(1)})
  ),
  s({trig = "vmat"},
    fmta("\\begin{vmatrix}\n<>\n\\end{vmatrix}", {i(1)})
  ),
  s({trig = "Vmat"},
    fmta("\\begin{Vmatrix}\n<>\n\\end{Vmatrix}", {i(1)})
  ),
  s({trig = "matrix"},
    fmta("\\begin{matrix}\n<>\n\\end{matrix}", {i(1)})
  ),
  s({trig = "cases", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\begin{cases}\n<>\n\\end{cases}", {i(1)})
  ),
  s({trig = "alg", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\begin{align}\n<>\n\\end{align}", {i(1)})
  ),
  s({trig = "array", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\begin{array}\n<>\n\\end{array}", {i(1)})
  ),

  -- Brackets
  s({trig = "avg", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\langle <> \\rangle <>", {i(1), i(2)})
  ),
  s({trig = "norm", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\lvert <> \\rvert <>", {i(1), i(2)})
  ),
  s({trig = "Norm", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\lVert <> \\rVert <>", {i(1), i(2)})
  ),
  s({trig = "ceil", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\lceil <> \\rceil <>", {i(1), i(2)})
  ),
  s({trig = "floor", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\lfloor <> \\rfloor <>", {i(1), i(2)})
  ),
  s({trig = "mod", snippetType = "autosnippet", condition = in_mathzone},
    fmta("|<>|<>", {i(1), i(2)})
  ),
  s({trig = "circ", snippetType = "autosnippet", condition = in_mathzone}, t("\\circ")),
  s({trig = "cor", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\{ <> \\}<>", {i(1), i(2)})
  ),
  s({trig = "lr(", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\left( <> \\right) <>", {i(1), i(2)})
  ),
  s({trig = "lr{", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\left\\{ <> \\right\\} <>", {i(1), i(2)})
  ),
  s({trig = "lr[", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\left[ <> \\right] <>", {i(1), i(2)})
  ),
  s({trig = "lr|", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\left| <> \\right| <>", {i(1), i(2)})
  ),
  s({trig = "lra", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\left< <> \\right> <>", {i(1), i(2)})
  ),

  -- Physics
  s({trig = "kbt", snippetType = "autosnippet", condition = in_mathzone}, t("k_{B}T")),
  s({trig = "msun", snippetType = "autosnippet", condition = in_mathzone}, t("M_{\\odot}")),

  -- Quantum mechanics
  s({trig = "dag", snippetType = "autosnippet", condition = in_mathzone}, t("^{\\dagger}")),
  s({trig = "o+", snippetType = "autosnippet", condition = in_mathzone}, t("\\oplus ")),
  s({trig = "ox", snippetType = "autosnippet", condition = in_mathzone}, t("\\otimes ")),
  s({trig = "bra", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\bra{<>} <>", {i(1), i(2)})
  ),
  s({trig = "ket", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\ket{<>} <>", {i(1), i(2)})
  ),
  s({trig = "brk", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\braket{ <> | <> } <>", {i(1), i(2), i(3)})
  ),
  s({trig = "outer", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\ket{<>} \\bra{<>} <>", {i(1, "\\psi"), rep(1), i(2)})
  ),

  -- Chemistry
  s({trig = "pu", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\pu{ <> }", {i(1)})
  ),
  s({trig = "cee", snippetType = "autosnippet", condition = in_mathzone},
    fmta("\\ce{ <> }", {i(1)})
  ),
  s({trig = "he4", snippetType = "autosnippet", condition = in_mathzone}, t("{}^{4}_{2}He ")),
  s({trig = "he3", snippetType = "autosnippet", condition = in_mathzone}, t("{}^{3}_{2}He ")),
  s({trig = "iso", snippetType = "autosnippet", condition = in_mathzone},
    fmta("{}^{<>}_{<>}<>", {i(1, "4"), i(2, "2"), i(3, "He")})
  ),

  -- Taylor expansion
  s({trig = "tayl", snippetType = "autosnippet", condition = in_mathzone},
    fmta("<>(x + h) = <>(x) + <>'(x)h + <>''(x) \\frac{h^{2}}{2!} + \\dots<>", 
         {i(1, "f"), rep(1), rep(1), rep(1), i(2)})
  ),

  -- Identity matrix generator
  s({trig = "iden(%d+)", regTrig = true, condition = in_mathzone},
    f(function(args, snip)
      local n = tonumber(snip.captures[1])
      if not n or n <= 0 or n > 10 then
        return "\\text{Invalid matrix size}"
      end
      
      local result = {}
      for i = 1, n do
        local row = {}
        for j = 1, n do
          row[j] = (i == j) and "1" or "0"
        end
        table.insert(result, table.concat(row, " & "))
      end
      
      return "\\begin{pmatrix}\n" .. table.concat(result, " \\\\\n") .. "\n\\end{pmatrix}"
    end, {})
  ),

  -- Document templates
  s("article", {
    t("\\documentclass["), i(1, "11pt"), t("]{article}"),
    t({"", "\\usepackage[utf8]{inputenc}"}),
    t({"", "\\usepackage[T1]{fontenc}"}),
    t({"", "\\usepackage{amsmath,amsfonts,amssymb}"}),
    t({"", "\\usepackage{geometry}"}),
    t({"", "\\usepackage{graphicx}"}),
    t({"", "\\usepackage{hyperref}"}),
    t({"", ""}),
    t({"", "\\title{"}), i(2, "Title"), t("}"),
    t({"", "\\author{"}), i(3, "Author"), t("}"),
    t({"", "\\date{"}), f(get_date), t("}"),
    t({"", ""}),
    t({"", "\\begin{document}"}),
    t({"", ""}),
    t({"", "\\maketitle"}),
    t({"", ""}),
    t({"", "\\section{"}), i(4, "Introduction"), t("}"),
    t({"", ""}),
    i(0),
    t({"", ""}),
    t({"", "\\end{document}"}),
  }),

  -- Basic environments
  s("env", {
    t("\\begin{"), i(1, "environment"), t("}"),
    t({"", "  "}), i(0),
    t({"", "\\end{"}), rep(1), t("}"),
  }),

  -- Sectioning
  s("sec", {
    t("\\section{"), i(1, "Section Title"), t("}"),
    t({"", "\\label{sec:"}), i(2, "label"), t("}"),
    t({"", ""}),
    i(0),
  }),

  -- Figure
  s("figure", {
    t("\\begin{figure}["), i(1, "htbp"), t("]"),
    t({"", "  \\centering"}),
    t({"", "  \\includegraphics[width="}), i(2, "0.8"), t("\\textwidth]{"), i(3, "filename"), t("}"),
    t({"", "  \\caption{"}), i(4, "Caption"), t("}"),
    t({"", "  \\label{fig:"}), i(5, "label"), t("}"),
    t({"", "\\end{figure}"}),
    i(0),
  }),
  s("frame", {
    t("\\begin{frame}{"), i(1, "Frame Title"), t("}"),
    t({"", "  "}), i(0),
    t({"", "\\end{frame}"}),
  }),
  
  -- Block for beamer
  s("block", {
    t("\\begin{block}{"), i(1, "Block Title"), t("}"),
    t({"", "  "}), i(0),
    t({"", "\\end{block}"}),
  }),
}
