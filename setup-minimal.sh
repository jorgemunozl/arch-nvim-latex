#!/bin/bash

# Minimal NeoVim LaTeX Setup Script for Arch Linux
# This script installs and configures NeoVim with a minimal LaTeX environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging
LOG_FILE="install-minimal.log"
exec > >(tee -a "$LOG_FILE")
exec 2>&1

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE} Minimal NeoVim LaTeX Setup    ${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
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

install_minimal_latex() {
    print_step "Installing minimal LaTeX environment..."
    
    print_info "This minimal setup includes:"
    print_info "- texlive-core: Core LaTeX binaries and basic packages"
    print_info "- texlive-bin: LaTeX executables (pdflatex, xelatex, etc.)"
    print_info "- texlive-basic: Essential LaTeX packages"
    print_info "- texlive-latex: Standard LaTeX packages"
    print_info "- zathura: Lightweight PDF viewer"
    echo
    
    local minimal_latex_packages=(
        "texlive-core"      # Core LaTeX system
        "texlive-bin"       # LaTeX executables
        "texlive-basic"     # Basic LaTeX packages
        "texlive-latex"     # Standard LaTeX packages
        "zathura"           # PDF viewer
        "zathura-pdf-mupdf" # PDF support for zathura
    )
    
    for package in "${minimal_latex_packages[@]}"; do
        print_info "Installing $package..."
        sudo pacman -S --needed --noconfirm "$package"
    done
    
    print_info "Minimal LaTeX installation complete!"
    echo
    print_warning "Additional packages you might want to install later:"
    print_warning "- texlive-latexrecommended: Recommended LaTeX packages"
    print_warning "- texlive-latexextra: Extra LaTeX packages"
    print_warning "- texlive-fontsrecommended: Recommended fonts"
    print_warning "- texlive-mathscience: Math and science packages"
    print_warning "- texlive-bibtexextra: Bibliography tools"
    print_warning "- biber: Modern bibliography processor"
    echo
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
    print_step "Installing essential language servers..."
    
    # Install minimal LSP servers via npm
    print_info "Installing essential LSP servers via npm..."
    sudo npm install -g \
        bash-language-server \
        yaml-language-server \
        json-language-server
    
    # Install Python tools
    print_info "Installing Python tools..."
    pip install --user \
        pynvim
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
EOF

    print_info "Zathura configured for LaTeX workflow"
}

create_test_latex_file() {
    print_step "Creating test LaTeX file..."
    
    local test_dir="$HOME/latex-test"
    mkdir -p "$test_dir"
    
    cat > "$test_dir/test.tex" << 'EOF'
\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}

\title{Minimal LaTeX Test}
\author{Your Name}
\date{\today}

\begin{document}

\maketitle

\section{Introduction}

This is a test document to verify that your minimal LaTeX installation is working correctly.

\section{Basic Features}

\subsection{Text Formatting}

You can make text \textbf{bold}, \textit{italic}, or \underline{underlined}.

\subsection{Lists}

Here's an itemized list:
\begin{itemize}
    \item First item
    \item Second item
    \item Third item
\end{itemize}

And a numbered list:
\begin{enumerate}
    \item First step
    \item Second step
    \item Third step
\end{enumerate}

\subsection{Mathematics}

Inline math: $E = mc^2$

Display math:
\[
    \int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
\]

\section{Conclusion}

If you can compile this document successfully, your minimal LaTeX setup is working!

\end{document}
EOF

    print_info "Test LaTeX file created at $test_dir/test.tex"
    print_info "You can test your installation by running:"
    print_info "  cd $test_dir"
    print_info "  pdflatex test.tex"
    print_info "  zathura test.pdf"
}

show_package_expansion_guide() {
    print_step "Package expansion guide..."
    echo
    print_info "Your minimal LaTeX installation is complete!"
    print_info "As you work on different types of documents, you can install additional packages:"
    echo
    
    cat << 'EOF'
# Common package groups to install later:

## For better font support:
sudo pacman -S texlive-fontsrecommended texlive-fontsextra

## For additional LaTeX packages:
sudo pacman -S texlive-latexrecommended texlive-latexextra

## For mathematics and science:
sudo pacman -S texlive-mathscience

## For bibliography management:
sudo pacman -S texlive-bibtexextra biber

## For graphics and images:
sudo pacman -S texlive-pictures

## For publishers' styles:
sudo pacman -S texlive-publishers

## For language support:
sudo pacman -S texlive-langeuropean texlive-langother

## For advanced formatting:
sudo pacman -S texlive-formatsextra

# You can also install specific packages using tlmgr:
# tlmgr install <package-name>
EOF
    echo
}

main() {
    print_header
    
    print_info "This script will install a minimal LaTeX environment with:"
    print_info "- Essential LaTeX packages (texlive-core, texlive-basic, texlive-latex)"
    print_info "- PDF viewer (zathura)"
    print_info "- LaTeX LSP server (texlab)"
    print_info "- NeoVim with LaTeX configuration"
    echo
    
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled."
        exit 0
    fi
    
    check_arch
    update_system
    install_base_packages
    install_minimal_latex
    install_aur_packages
    setup_neovim_config
    install_language_servers
    configure_zathura
    create_test_latex_file
    show_package_expansion_guide
    
    print_step "Installation complete!"
    echo
    print_info "Your minimal LaTeX environment is ready!"
    print_info "Start NeoVim and open a .tex file to begin using LaTeX."
    print_info "Use the test file at ~/latex-test/test.tex to verify everything works."
    echo
    print_info "To expand your LaTeX installation later, refer to the package guide above."
    print_info "Log file saved to: $LOG_FILE"
}

# Run main function
main "$@"
