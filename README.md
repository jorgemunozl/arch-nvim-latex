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
git clone <repository-url>
cd landscape
```

2. Run the setup script:
```bash
chmod +x setup.sh
./setup.sh
```

3. Start NeoVim and enjoy your LaTeX environment!

## What's Included

### System Packages
- NeoVim (latest version)
- TexLive (full LaTeX distribution)
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
- ltex LSP for grammar checking
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
1. Check the installation log: `cat install.log`
2. Verify all packages are installed: `./setup.sh --verify`
3. Reset NeoVim configuration: `./setup.sh --reset`

## Contributing

Feel free to submit issues and pull requests to improve this setup.

## License

MIT License - see LICENSE file for details.
