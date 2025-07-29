# Minimal LaTeX Installation Guide

This guide helps you install a minimal LaTeX distribution that you can expand over time as needed.

## Quick Start (Minimal Installation)

1. **Run the minimal setup script:**
```bash
chmod +x setup-minimal.sh
./setup-minimal.sh
```

## What's Included in the Minimal Installation

### Core LaTeX Packages
- **texlive-core**: Core LaTeX system with essential binaries
- **texlive-bin**: LaTeX executables (pdflatex, xelatex, lualatex, etc.)
- **texlive-basic**: Basic LaTeX packages for document creation
- **texlive-latex**: Standard LaTeX packages and classes

### Tools
- **zathura**: Lightweight PDF viewer with LaTeX integration
- **texlab**: LaTeX Language Server for NeoVim
- **NeoVim**: Configured with LaTeX support

## Size Comparison

| Installation Type | Approximate Size | Packages |
|-------------------|------------------|----------|
| **Minimal** | ~150-200 MB | 4 core packages |
| **Full** (original) | ~2-3 GB | 12+ package groups |

## Testing Your Installation

After installation, test with the provided example:

```bash
cd ~/latex-test
pdflatex test.tex
zathura test.pdf
```

## Expanding Your Installation

As you encounter missing packages, you can install additional groups:

### Common Expansions

#### 1. **Recommended Packages** (when you need more LaTeX functionality)
```bash
sudo pacman -S texlive-latexrecommended
```

#### 2. **Font Support** (when you need different fonts)
```bash
sudo pacman -S texlive-fontsrecommended
```

#### 3. **Mathematics** (for scientific documents)
```bash
sudo pacman -S texlive-mathscience
```

#### 4. **Bibliography** (for references and citations)
```bash
sudo pacman -S texlive-bibtexextra biber
```

#### 5. **Graphics** (for advanced graphics and diagrams)
```bash
sudo pacman -S texlive-pictures
```

### Installing Specific Packages

If you need a specific LaTeX package, you can install it using `tlmgr`:

```bash
# First, initialize tlmgr for user packages
tlmgr init-usertree

# Then install specific packages
tlmgr install <package-name>
```

### Common Missing Packages and Solutions

| Error Message | Missing Package | Solution |
|---------------|-----------------|----------|
| `! LaTeX Error: File 'geometry.sty' not found` | geometry package | `sudo pacman -S texlive-latexrecommended` |
| `! LaTeX Error: File 'amsmath.sty' not found` | amsmath package | `sudo pacman -S texlive-mathscience` |
| `! LaTeX Error: File 'graphicx.sty' not found` | graphicx package | `sudo pacman -S texlive-latexrecommended` |
| `! LaTeX Error: File 'babel.sty' not found` | babel package | `sudo pacman -S texlive-latexrecommended` |
| `! LaTeX Error: File 'biblatex.sty' not found` | biblatex package | `sudo pacman -S texlive-bibtexextra` |

## Package Groups Reference

### Essential (Included in Minimal)
- `texlive-core` - Core LaTeX system
- `texlive-bin` - LaTeX executables
- `texlive-basic` - Basic packages
- `texlive-latex` - Standard LaTeX

### Level 1 Expansion (Most Common)
- `texlive-latexrecommended` - Recommended packages (geometry, graphicx, etc.)
- `texlive-fontsrecommended` - Recommended fonts

### Level 2 Expansion (Specialized)
- `texlive-mathscience` - Mathematics and science packages
- `texlive-bibtexextra` - Bibliography tools
- `biber` - Modern bibliography processor

### Level 3 Expansion (Advanced)
- `texlive-latexextra` - Extra LaTeX packages
- `texlive-fontsextra` - Extra fonts
- `texlive-pictures` - Graphics packages
- `texlive-publishers` - Publisher-specific styles

### Level 4 Expansion (Comprehensive)
- `texlive-formatsextra` - Additional formats
- `texlive-langeuropean` - European language support
- `texlive-langother` - Other language support

## Workflow

1. **Start with minimal installation**
2. **Create/edit your documents**
3. **When you encounter missing packages:**
   - Note the error message
   - Check the reference table above
   - Install the appropriate package group
   - Recompile your document

## Tips

- **Start minimal**: Only install what you need
- **Incremental approach**: Add packages as you encounter missing functionality
- **Document your additions**: Keep track of what you install for future reference
- **Use package groups**: They're more efficient than individual packages

## 🚀 Beginner's Guide: Starting Your First LaTeX Project

### Step 1: Create a Project Directory
```bash
mkdir ~/my-first-latex-project
cd ~/my-first-latex-project
```

### Step 2: Create Your First LaTeX Document
Create a file called `document.tex`:

```latex
\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage[margin=1in]{geometry}

\title{My First LaTeX Document}
\author{Your Name}
\date{\today}

\begin{document}

\maketitle

\section{Introduction}

Welcome to LaTeX! This is your first document.

\section{Basic Formatting}

You can make text \textbf{bold}, \textit{italic}, or \texttt{monospace}.

\subsection{Lists}

Here's a bulleted list:
\begin{itemize}
    \item First item
    \item Second item
    \item Third item
\end{itemize}

And a numbered list:
\begin{enumerate}
    \item Step one
    \item Step two
    \item Step three
\end{enumerate}

\section{Mathematics}

LaTeX excels at mathematics. Here's an inline equation: $E = mc^2$.

And here's a displayed equation:
\[
    \sum_{i=1}^{n} i = \frac{n(n+1)}{2}
\]

\section{Conclusion}

This is just the beginning of your LaTeX journey!

\end{document}
```

### Step 3: Compile Your Document

#### Option A: Using the Terminal
```bash
pdflatex document.tex
```

#### Option B: Using NeoVim
1. Open the file in NeoVim: `nvim document.tex`
2. Use the built-in LaTeX commands (configured in your setup)
3. The PDF will be generated automatically

### Step 4: View Your PDF
```bash
zathura document.pdf
```

### Step 5: Understanding the LaTeX Structure

#### Document Class
```latex
\documentclass{article}  % Other options: book, report, letter
```

#### Preamble (before \begin{document})
```latex
\usepackage{package-name}  % Load packages
\title{Document Title}     % Set title
\author{Author Name}       % Set author
\date{\today}             % Set date (or specific date)
```

#### Document Body (between \begin{document} and \end{document})
```latex
\maketitle                % Generate title page
\section{Section Name}    % Create sections
\subsection{Subsection}   % Create subsections
```

### Common LaTeX Commands for Beginners

| Command | Purpose | Example |
|---------|---------|---------|
| `\section{Title}` | Create a section | `\section{Introduction}` |
| `\subsection{Title}` | Create a subsection | `\subsection{Background}` |
| `\textbf{text}` | Bold text | `\textbf{important}` |
| `\textit{text}` | Italic text | `\textit{emphasis}` |
| `\texttt{text}` | Monospace text | `\texttt{code}` |
| `\\` | Line break | `First line \\ Second line` |
| `\newpage` | Page break | `\newpage` |
| `%` | Comment | `% This is a comment` |

### Project Organization Tips

#### Simple Project Structure
```
my-project/
├── document.tex         # Main document
├── document.pdf         # Generated PDF
└── images/             # Folder for images (if needed)
```

#### Multi-Chapter Project Structure
```
my-book/
├── main.tex            # Main document
├── chapters/
│   ├── introduction.tex
│   ├── chapter1.tex
│   └── chapter2.tex
├── images/
└── bibliography.bib    # Bibliography file
```

### Next Steps After Your First Document

1. **Add an image**: Learn `\includegraphics{}`
2. **Create tables**: Learn `tabular` environment
3. **Add citations**: Learn bibliography management
4. **Write math**: Explore `amsmath` package
5. **Customize appearance**: Learn about document classes and packages

### Common Beginner Mistakes to Avoid

1. **Forgetting to escape special characters**: Use `\$`, `\%`, `\&`, `\#` for literal symbols
2. **Missing packages**: If you get "command not found" errors, you might need to install packages
3. **Unmatched braces**: Always match `{` with `}`
4. **Wrong file extension**: LaTeX files should end with `.tex`
5. **Compilation errors**: Read error messages carefully - they usually point to the problem line

### Development Workflow

1. **Edit** your `.tex` file in NeoVim
2. **Compile** with `pdflatex` or use NeoVim shortcuts
3. **View** the PDF with `zathura`
4. **Iterate** - make changes and recompile
5. **Version control** - use git to track changes

### Getting Help

- **Error messages**: LaTeX gives detailed error messages - read them carefully
- **Package documentation**: Use `texdoc package-name` to read documentation
- **Online resources**: TeX Stack Exchange, Overleaf documentation
- **Local help**: `man pdflatex`, `man latex`

## NeoVim Integration

The minimal setup includes full NeoVim integration with:
- LaTeX LSP support (texlab)
- Syntax highlighting
- Snippet support
- PDF preview with zathura
- Compilation shortcuts

Open any `.tex` file in NeoVim to start using the LaTeX environment!
