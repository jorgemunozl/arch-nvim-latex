# NeoVim LaTeX Setup for Arch Linux

Automated Arch-focused workflow that installs NeoVim, LaTeX tooling, and a tuned configuration for writing, compiling, and previewing TeX documents.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Quick Start](#quick-start)
- [Installation Profiles](#installation-profiles)
- [Components](#components)
- [Usage Essentials](#usage-essentials)
- [Snippet Tips](#snippet-tips)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Overview
- One-command bootstrap that provisions NeoVim, TeX Live, texlab, and supporting tooling
- Opinionated config built on `lazy.nvim`, VimTeX, LuaSnip, Telescope, Treesitter, and Git utilities
- Zathura viewer integration with forward and inverse SyncTeX search out of the box

## Requirements
- Arch Linux or a compatible Arch-based distribution
- Internet connectivity for package downloads
- ≥ 2 GB free disk space (more for full TeX Live)

## Quick Start
1. Clone the repo:
   ```bash
   git clone git@github.com:jorgemunozl/arch-nvim-latex.git
   cd arch-nvim-latex
   ```
2. Run the installer:
   ```bash
   chmod +x setup.sh
   ./setup.sh                 # guided
   ./setup.sh --yes           # defaults to medium profile
   ./setup.sh --level full --yes --skip-aur   # example with flags
   ```
3. Launch NeoVim, wait for plugins to sync, and open a `.tex` buffer to begin.

## Installation Profiles
During execution the script prompts for a TeX Live scope unless provided via `--level`:

| Profile  | Contents (summary)                              | Footprint* |
|----------|-------------------------------------------------|------------|
| minimal  | Core TeX Live plus latexmk and Zathura          | ~200 MB    |
| medium   | Core + recommended + math + fonts + biber       | ~700 MB    |
| full     | Full TeX Live collection with publishers extras | ~2–3 GB    |

\* Approximate download size; actual usage varies with mirrors and dependencies.

Profiles can be extended later with `pacman` or `tlmgr` if required.

## Components
**System packages**: NeoVim, Git, build toolchain, Python, Node.js, ripgrep, fd, fzf, tree-sitter.

**LaTeX stack**: TeX Live per profile, latexmk, biber (medium/full), Zathura with SyncTeX inverse search via `nvr`.

**NeoVim configuration**:
- `lazy.nvim` plugin manager with plugin set defined in `nvim/lua/plugins/`
- VimTeX, texlab LSP, LuaSnip, Treesitter, Telescope, nvim-tree, Fugitive, and UI refinements
- Custom LuaSnip snippets installed under `~/.config/nvim/snippets`

## Usage Essentials
**Live workflow**
1. `<leader>ll` — start/stop latexmk (continuous build)
2. `<leader>lv` — open current PDF in Zathura
3. `<leader>lc` — clean auxiliary files

**Navigation & search**
- `<leader>ff` find files, `<leader>fg` ripgrep, `<leader>e` file explorer, `<leader>gg` Git status
- `tt` compile, `tv` view, `tc` toggle VimTeX TOC, `te`/`ta` insert equation or align blocks (normal mode, `.tex` buffers)

**Inverse search**
- Ctrl+Left Click (or configured Zathura shortcut) jumps back to the matching line in Neovim via `nvr`.

## Snippet Tips
- Snippets live in `~/.config/nvim/snippets`
- Expand or jump forward with `Tab` / `Ctrl-l`, backward with `Shift-Tab` / `Ctrl-h`
- Choice nodes cycle with `Ctrl-k`
- Autosnippets in math mode: `@a → \alpha`, `fra → \frac{…}{…}`, `sq → \sqrt{…}`
- Reload without restarting NeoVim:
  ```vim
  :lua require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/snippets/lua/' })
  ```

## Troubleshooting
- Inspect the latest installer log:\
  `ls -1t install_*.log | head -n1 | xargs -r tail -n +1`
- Verify tooling after manual changes: `./setup.sh --verify`
- Reset the NeoVim configuration from this repo: `./setup.sh --reset`
- Snippets not expanding?
  - Check VimTeX math context: `:echo exists('*vimtex#syntax#in_mathzone')`
  - Reload snippets using the command above

## Contributing
Issues and pull requests are welcome. Please describe your environment, profile, and reproduction steps when reporting problems.

## License
Released under the MIT License—see `LICENSE`.
