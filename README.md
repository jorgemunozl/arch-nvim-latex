# NeoVim LaTeX Setup for Arch Linux

A comprehensive setup script and configuration for NeoVim with LaTeX support on Arch Linux.

## Features

- Complete NeoVim installation with modern plugin manager (lazy.nvim)
- LaTeX environment with TexLive
- LSP support for LaTeX with texlab
- Snippet support with LuaSnip
- PDF viewer integration with Zathura
- Git integration and version control
- Modern UI with telescope, treesitter, and more

## Quick Start

1. Clone this repository:
```bash
git clone git@github.com:jorgemunozl/arch-nvim-latex.git
cd arch-nvim-latex
```

2. Run the setup script:
```bash
chmod +x setup.sh
./setup.sh                 # interactive
./setup.sh --yes           # non-interactive (medium)
./setup.sh --level full --yes --skip-aur   # example with flags
```

3. When prompted, choose your LaTeX installation level:
   - **Minimal**: Only core and basic LaTeX packages (smallest, fastest)
   - **Medium**: Core + recommended + math + fonts (recommended for most users)
   - **Full**: Everything (all available LaTeX packages, largest install)

4. Start NeoVim and enjoy your LaTeX environment!

---

## LaTeX Installation Levels

When you run `setup.sh`, you will be asked to choose one of three LaTeX installation levels:

- **Minimal**: Installs only the essential LaTeX packages for basic documents. Fastest and smallest.
- **Medium**: Installs core, recommended, math, and font packages. Suitable for most users and most documents.
- **Full**: Installs all available LaTeX packages. Largest install, but ensures you never run into missing packages.

You can always add more packages later using `pacman` or `tlmgr` as your needs grow.

## Average Disk Space Usage

| Installation Type | Approximate Size |
|-------------------|------------------|
| **Minimal**       | ~200 MB          |
| **Medium**        | ~700 MB          |
| **Full**          | ~2–3 GB          |

These are rough estimates and may vary depending on updates and dependencies. You can always expand your installation later as needed.

---

## What's Included

### System Packages
- NeoVim (latest version)
- TexLive (core and selected package groups based on your installation level)
- texlive-binextra (important for extra utilities like latexmk)
- Zathura (PDF viewer)
- Git and development tools
- Python and Node.js for LSP servers

### NeoVim Configuration
- Modern plugin manager (lazy.nvim)
- LSP configuration for LaTeX
- Treesitter syntax highlighting
- Telescope fuzzy finder
- File explorer with nvim-tree
- Git integration with fugitive
- LaTeX-specific snippets and keybindings

### LaTeX Tools
- texlab LSP server
- VimTeX plugin for LaTeX support
- Live preview capabilities

## Usage

### Basic LaTeX Workflow
1. Create a new `.tex` file
2. Use `<leader>ll` to start live compilation
3. Use `<leader>lv` to open PDF viewer
4. Use `<leader>lc` to clean auxiliary files

### Key Bindings
- `<leader>ff` - Find files with Telescope
- `<leader>fg` - Live grep with Telescope
- `<leader>e` - Toggle file explorer
- `<leader>gg` - Open Git status
- `<leader>ll` - LaTeX live compilation
- `<leader>lv` - LaTeX view PDF

## Snippets
- Location: `~/.config/nvim/snippets` (installed by `setup.sh`)
- Expand/jump: Tab or Ctrl-l
- Jump back: Shift-Tab or Ctrl-h
- Choice nodes: Ctrl-k
- Autosnippets (math): e.g. `@a` → `\alpha`, `fra` → `\frac{…}{…}`, `sq` → `\sqrt{…}`
- Reload without restarting:
  - `:lua require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config')..'/snippets/lua/' })`

## Customization

Edit the configuration files in `nvim/` directory to customize your setup:
- `nvim/init.lua` - Main configuration
- `nvim/lua/plugins/` - Plugin configurations
- `nvim/lua/config/` - Core settings

## Requirements

- Arch Linux (or Arch-based distribution)
- Internet connection for package installation
- At least 2GB free disk space

## Troubleshooting

If you encounter issues:
1. Check the latest install log (in this repo directory):
   - `ls -1t install_*.log | head -n1 | xargs -r tail -n +1`
2. Verify all packages are installed: `./setup.sh --verify`
3. Reset NeoVim configuration: `./setup.sh --reset`
4. Snippets not expanding?
   - Open a `.tex` buffer and run: `:lua print(#require('luasnip').get_snippets('tex'))` (should be > 0)
   - Reload snippets: `:lua require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config')..'/snippets/lua/' })`
   - Ensure VimTeX is active (mathzone): `:echo exists('*vimtex#syntax#in_mathzone')`

## Contributing

Feel free to submit issues and pull requests to improve this setup.

## License

MIT License - see LICENSE file for details.
