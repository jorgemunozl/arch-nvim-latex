#!/bin/bash

# NeoVim LaTeX Setup Script for Arch Linux
# This script installs and configures NeoVim with a complete LaTeX environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging
LOG_FILE="install.log"
exec > >(tee -a "$LOG_FILE")
exec 2>&1


print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  NeoVim LaTeX Setup for Arch  ${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
}

# Prompt for LaTeX installation level
choose_latex_install_level() {
    echo -e "${GREEN}Choose your LaTeX installation level:${NC}"
    echo "  1) Minimal   - Only core and basic packages (smallest, fastest)"
    echo "  2) Medium    - Core + recommended + math + fonts (most users)"
    echo "  3) Full      - Everything (all packages, largest)"
    echo
    local choice
    while true; do
        read -p "Enter 1 (Minimal), 2 (Medium), or 3 (Full) [2]: " choice
        case $choice in
            1) LATEX_LEVEL="minimal"; break;;
            2|"") LATEX_LEVEL="medium"; break;;
            3) LATEX_LEVEL="full"; break;;
            *) echo "Please enter 1, 2, or 3.";;
        esac
    done
    print_info "Selected LaTeX installation: $LATEX_LEVEL"
}

print_step() {
    echo -e "${GREEN}[STEP]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_arch() {
    if ! command -v pacman &> /dev/null; then
        print_error "This script is designed for Arch Linux and requires pacman"
        exit 1
    fi
    print_info "Arch Linux detected ✓"
}

update_system() {
    print_step "Updating system packages..."
    sudo pacman -Syu --noconfirm
}

install_base_packages() {
    print_step "Installing base packages..."
    
    local packages=(
        "neovim"
        "git"
        "curl"
        "wget"
        "unzip"
        "gcc"
        "make"
        "nodejs"
        "npm"
        "python"
        "python-pip"
        "ripgrep"
        "fd"
        "fzf"
        "tree-sitter"
        "tree-sitter-cli"
    )
    
    for package in "${packages[@]}"; do
        print_info "Installing $package..."
        sudo pacman -S --needed --noconfirm "$package"
    done
}

install_latex() {
    print_step "Installing LaTeX environment..."
    local latex_packages=()
    if [[ "$LATEX_LEVEL" == "minimal" ]]; then
        latex_packages=(
            "texlive-core"
            "texlive-bin"
            "texlive-basic"
            "texlive-latex"
            "zathura"
            "zathura-pdf-mupdf"
        )
    elif [[ "$LATEX_LEVEL" == "medium" ]]; then
        latex_packages=(
            "texlive-core"
            "texlive-bin"
            "texlive-basic"
            "texlive-latex"
            "texlive-latexrecommended"
            "texlive-fontsrecommended"
            "texlive-mathscience"
            "biber"
            "zathura"
            "zathura-pdf-mupdf"
        )
    else # full
        latex_packages=(
            "texlive-core"
            "texlive-bin"
            "texlive-basic"
            "texlive-latex"
            "texlive-latexrecommended"
            "texlive-latexextra"
            "texlive-fontsrecommended"
            "texlive-fontsextra"
            "texlive-formatsextra"
            "texlive-bibtexextra"
            "texlive-mathscience"
            "texlive-publishers"
            "biber"
            "zathura"
            "zathura-pdf-mupdf"
        )
    fi
    for package in "${latex_packages[@]}"; do
        print_info "Installing $package..."
        sudo pacman -S --needed --noconfirm "$package"
    done
}

install_aur_packages() {
    print_step "Installing AUR packages..."
    
    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        print_info "Installing yay AUR helper..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
    fi
    
    # Install texlab (LaTeX LSP server)
    print_info "Installing texlab LSP server..."
    yay -S --needed --noconfirm texlab
}

setup_neovim_config() {
    print_step "Setting up NeoVim configuration..."
    
    local nvim_config_dir="$HOME/.config/nvim"
    local backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Backup existing configuration
    if [ -d "$nvim_config_dir" ]; then
        print_warning "Backing up existing NeoVim configuration to $backup_dir"
        mv "$nvim_config_dir" "$backup_dir"
    fi
    
    # Create config directory
    mkdir -p "$nvim_config_dir"
    
    # Copy our configuration
    cp -r nvim/* "$nvim_config_dir/"
    
    print_info "NeoVim configuration installed to $nvim_config_dir"
}

install_language_servers() {
    print_step "Installing language servers and tools..."
    
    # Install LSP servers via npm
    print_info "Installing LSP servers via npm..."
    sudo npm install -g \
        bash-language-server \
        typescript-language-server \
        pyright \
        yaml-language-server \
        json-language-server
    
    # Install Python tools using pacman
    print_info "Installing Python tools with pacman..."
    sudo pacman -S --needed --noconfirm python-pynvim python-black python-isort python-flake8 python-mypy
}

configure_zathura() {
    print_step "Configuring Zathura PDF viewer..."
    
    local zathura_config_dir="$HOME/.config/zathura"
    mkdir -p "$zathura_config_dir"
    
    cat > "$zathura_config_dir/zathurarc" << 'EOF'
# Zathura configuration for LaTeX workflow

# Set default page padding
set page-padding 1

# Set recolor for dark mode
set recolor true
set recolor-lightcolor "#1e1e1e"
set recolor-darkcolor "#d4d4d4"

# Set default zoom
set zoom-center true
set zoom-step 20

# Key bindings
map <C-r> reload
map <C-o> toggle_page_mode
map r rotate

# Colors
set default-bg "#1e1e1e"
set statusbar-bg "#1e1e1e"
set statusbar-fg "#d4d4d4"
set inputbar-bg "#1e1e1e"
set inputbar-fg "#d4d4d4"

# Font
set font "JetBrains Mono 11"
EOF
    
    print_info "Zathura configured"
}

setup_git_hooks() {
    print_step "Setting up Git hooks..."
    
    # Create a sample pre-commit hook for LaTeX
    local hooks_dir=".git/hooks"
    mkdir -p "$hooks_dir"
    
    cat > "$hooks_dir/pre-commit" << 'EOF'
#!/bin/bash
# Pre-commit hook for LaTeX projects

# Check for LaTeX syntax errors
for tex_file in $(git diff --cached --name-only --diff-filter=ACM | grep '\.tex$'); do
    if [ -f "$tex_file" ]; then
        echo "Checking LaTeX syntax for $tex_file..."
        # Basic syntax check using lacheck if available
        if command -v lacheck &> /dev/null; then
            lacheck "$tex_file" || exit 1
        fi
    fi
done

echo "Pre-commit checks passed!"
EOF
    
    chmod +x "$hooks_dir/pre-commit"
    print_info "Git pre-commit hook installed"
}

verify_installation() {
    print_step "Verifying installation..."
    
    local errors=0
    
    # Check if NeoVim is installed
    if command -v nvim &> /dev/null; then
        print_info "✓ NeoVim installed: $(nvim --version | head -n1)"
    else
        print_error "✗ NeoVim not found"
        ((errors++))
    fi
    
    # Check if LaTeX is installed
    if command -v pdflatex &> /dev/null; then
        print_info "✓ LaTeX installed: $(pdflatex --version | head -n1 | cut -d' ' -f1-2)"
    else
        print_error "✗ LaTeX not found"
        ((errors++))
    fi
    
    # Check if texlab is installed
    if command -v texlab &> /dev/null; then
        print_info "✓ texlab LSP server installed"
    else
        print_error "✗ texlab LSP server not found"
        ((errors++))
    fi
    
    # Check if Zathura is installed
    if command -v zathura &> /dev/null; then
        print_info "✓ Zathura PDF viewer installed"
    else
        print_error "✗ Zathura PDF viewer not found"
        ((errors++))
    fi
    
    # Check NeoVim config
    if [ -f "$HOME/.config/nvim/init.lua" ]; then
        print_info "✓ NeoVim configuration installed"
    else
        print_error "✗ NeoVim configuration not found"
        ((errors++))
    fi
    
    if [ $errors -eq 0 ]; then
        print_info "All components verified successfully!"
        return 0
    else
        print_error "$errors errors found during verification"
        return 1
    fi
}

show_next_steps() {
    print_step "Installation completed!"
    echo
    echo -e "${GREEN}Next steps:${NC}"
    echo "1. Start NeoVim: nvim"
    echo "2. Wait for plugins to install automatically"
    echo "3. Create a test LaTeX file: nvim test.tex"
    echo "4. Use <leader>ll to start live compilation"
    echo "5. Use <leader>lv to open PDF viewer"
    echo
    echo -e "${BLUE}Key bindings:${NC}"
    echo "  <leader>ff - Find files"
    echo "  <leader>fg - Live grep"
    echo "  <leader>e  - File explorer"
    echo "  <leader>gg - Git status"
    echo "  <leader>ll - LaTeX compile"
    echo "  <leader>lv - LaTeX view PDF"
    echo
    echo -e "${YELLOW}Note:${NC} The leader key is set to <Space>"
    echo
    echo "Check the log file for details: $LOG_FILE"
}


main() {
    print_header

    # Parse command line arguments
    case "${1:-}" in
        --verify)
            verify_installation
            exit $?
            ;;
        --reset)
            print_step "Resetting NeoVim configuration..."
            rm -rf "$HOME/.config/nvim"
            setup_neovim_config
            print_info "NeoVim configuration reset"
            exit 0
            ;;
        --help)
            echo "Usage: $0 [--verify|--reset|--help]"
            echo "  --verify  Verify installation"
            echo "  --reset   Reset NeoVim configuration"
            echo "  --help    Show this help"
            exit 0
            ;;
    esac

    # Ask user for LaTeX installation level
    choose_latex_install_level

    # Main installation process
    check_arch
    update_system
    install_base_packages
    install_latex
    install_aur_packages
    setup_neovim_config
    install_language_servers
    configure_zathura
    setup_git_hooks

    if verify_installation; then
        show_next_steps
    else
        print_error "Installation completed with errors. Check the log for details."
        exit 1
    fi
}

# Run main function
main "$@"
