# Salar's Neovim Config

## Architecture

- **Entry point:** `init.lua` — truncates LSP log if >10MB, sets LSP log level to ERROR, then loads `salar.core` and `salar.lazy`
- **Plugin manager:** lazy.nvim (stable branch, auto-bootstrapped), imports `salar.plugins` + `salar.plugins.lsp`
- **Namespace:** everything under `lua/salar/` — core settings, plugin configs, LSP configs, and custom tools

```
neovim_configuration/
  init.lua                          # Entry point
  lazy-lock.json                    # Lazy.nvim lockfile (commit pinning)
  lua/salar/
    lazy.lua                        # Plugin manager bootstrap
    core/
      init.lua                      # Core module aggregator
      options.lua                   # vim.opt settings
      keymaps.lua                   # General keybindings
      colorschemes.lua              # Colorscheme catalog (17 themes)
      theme.lua                     # Theme switcher/cycler (with persistence)
      koda.lua                      # Custom koda colorscheme variant overrides
      godot.lua                     # Godot server auto-start
      obsidian.lua                  # Obsidian workspace/note configuration
    plugins/
      init.lua                      # Shared dependencies (plenary, vim-tmux-navigator)
      alpha.lua                     # Dashboard
      autopairs.lua                 # Auto-pair brackets
      bufdelete.lua                 # Safe buffer deletion
      bufferline.lua                # Buffer tabs
      colorscheme.lua               # All colorscheme specs (generated from catalog)
      color_shower.lua              # nvim-colorizer
      dap.lua                       # Debug adapter protocol
      dap-ui.lua                    # DAP UI panel
      dap-virtual-text.lua          # Inline debug values
      dressing.lua                  # UI dressing for vim.ui
      drop.lua                      # Dashboard drop animation
      highlit_notes.lua             # todo-comments.nvim
      lualine.lua                   # Statusline
      luasnip.lua                   # Snippet engine
      mini-move.lua                 # Mini.move for smart text movement
      nvim-cmp.lua                  # Completion engine
      nvim-tree.lua                 # File explorer
      nvim-ufo.lua                  # Fold management
      obsidian.lua                  # Obsidian note-taking
      presence.lua                  # Discord Rich Presence
      render-markdown.lua           # Markdown rendering
      rndr.lua                      # 3D model viewer (custom)
      satellite.lua                 # Scrollbar

      snacks.lua                    # Snacks utility collection
      surround.lua                  # Surround text objects
      telescope.lua                 # Fuzzy finder
      todo_marker.lua               # conform.nvim (GDScript formatting)
      treesitter.lua                # Syntax highlighting & selection
      trouble.lua                   # Diagnostics list
      lsp/
        mason.lua                   # LSP installer
        lspconfig.lua               # LSP per-server configs
    tools/
      init.lua                      # Tool aggregator (autocmds + commands)
      include_formatter.lua         # C/C++ #include sorter/formatter
      include_rename.lua            # C/C++ include-rewriter on file rename
      skeleton.lua                  # C++ file boilerplate (header/source)
      cpp_extract.lua               # C++ "extract to .cpp" refactoring
```

---

## Core Settings (`lua/salar/core/`)

### Options
- Relative + absolute line numbers
- Hard tabs (tabstop=8, shiftwidth=8, no expandtab)
- Smart/auto/preserve indent on all filetypes
- No wrap (except markdown), `cursorline`, dark background, `termguicolors`
- Smart/ignore case search, system clipboard (`unnamedplus`)
- Splits open right and below
- Folding: marker-based with `#pragma region / #pragma endregion`
- Custom filetype associations: `.gd`→gdscript, `.tscn/.tres`→gdresource, `project.godot`→godot

### Keymaps (leader: `<Space>`)

| Key | Action |
|-----|--------|
| `Ctrl+u` / `Ctrl+d` | Half-page scroll + center cursor |
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Equalize split sizes |
| `<leader>sx` | Close current split |
| `Ctrl+Up/Down` | Increase/decrease window height |
| `Ctrl+Left/Right` | Increase/decrease window width |
| `Tab` / `Shift+Tab` | Next / previous buffer |
| `<leader>x` | Close current buffer |
| `<leader>n` | New tab |
| `<leader>h` / `<leader>l` | Move buffer left / right |
| `J` / `K` (visual) | Move selected block down / up |
| `<leader>e` | Focus NvimTree |
| `Ctrl+n` | Toggle NvimTree |
| `<leader>ff` | Telescope find files |
| `<leader>fw` | Telescope live grep |
| `<leader>fc` | Telescope grep word under cursor |
| `<leader>ci` | Telescope LSP incoming calls |
| `<leader>co` | Telescope LSP outgoing calls |
| `<leader>ch` | Telescope LSP implementations |
| `<leader>cu` | Telescope LSP references |
| `<leader>ts` | Select theme |
| `<leader>tn` | Next theme |
| `<leader>tp` | Previous theme |
| `Esc` (terminal) | Return to normal mode |

### Theme System (17 themes, ~70+ variants)
- **Commands:** `:Theme [name]`, `:ThemeNext`, `:ThemePrev` (with tab-completion)
- **Persistence:** last theme saved to `~/.local/state/nvim/theme.txt`
- **koda overrides:** custom background colors for `koda-dark` (#090909) and `koda-moss` (#090d0e)

#### Available themes and variants
| Repository | Variants |
|-----------|----------|
| oskarnurm/koda.nvim | koda, koda-dark, koda-light, koda-glade, koda-moss |
| andreypopp/vim-colors-plain | plain, plain-cterm |
| folke/tokyonight.nvim | tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon |
| catppuccin/nvim | catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha |
| rebelot/kanagawa.nvim | kanagawa, kanagawa-wave, kanagawa-dragon, kanagawa-lotus |
| rose-pine/neovim | rose-pine, rose-pine-main, rose-pine-moon, rose-pine-dawn |
| ellisonleao/gruvbox.nvim | gruvbox |
| shaunsingh/nord.nvim | nord |
| navarasu/onedark.nvim | onedark |
| EdenEast/nightfox.nvim | nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox |
| sainnhe/everforest | everforest |
| sainnhe/sonokai | sonokai |
| sainnhe/edge | edge |
| marko-cerovac/material.nvim | material, material-darker, material-deep-ocean, material-lighter, material-oceanic, material-palenight |
| Mofiqul/dracula.nvim | dracula, dracula-soft |
| projekt0n/github-nvim-theme | github_dark, github_dark_default, github_dark_dimmed, github_dark_high_contrast, github_light, github_light_default, github_light_high_contrast |
| nyoom-engineering/oxocarbon.nvim | oxocarbon |
| RRethy/base16-nvim | base16-default-dark, base16-default-light |

---

## Plugins

### UI / Visual

| Plugin | What it does |
|--------|-------------|
| **alpha-nvim** | Start screen dashboard with ASCII art "SALAR" logo + quick buttons (e→new file, f→find file, q→quit) |
| **drop.nvim** | Dashboard animation effects |
| **bufferline** | Buffer tab bar — thin separators, auto-syncs highlight groups with colorscheme changes |
| **lualine** | Statusline — shows git branch, diagnostics, lazy.nvim update count, encoding, fileformat, filetype |
| **nvim-tree** | Left sidebar file explorer (width 35), follows focused file, `Ctrl+n` toggle, `<leader>e` focus |
| **satellite.nvim** | Scrollbar |

| **dressing.nvim** | Improved `vim.ui.select/input` UIs |
| **nvim-colorizer** | Inline color code highlighting (#hex, rgb) |
| **render-markdown** | Live markdown rendering (Neovim <0.12 only, Obsidian preset) |
| **presence.nvim** | Discord Rich Presence with Neovim logo and elapsed time |
| **rndr.nvim** | Custom 3D model viewer. Auto-opens preview on `BufReadPost`, supersample=2. Controls: `h/j/k/l` rotate, `0` reset, `R` rerender, `q` close |

### Completion & Snippets

| Plugin | What it does |
|--------|-------------|
| **nvim-cmp** | Completion engine — sources: LSP, LuaSnip, buffer words, filesystem paths |
| **LuaSnip** | Snippet engine with VSCode-style friendly-snippets |
| **lspkind** | VSCode-like icons in completion menu |

**cmp keybindings:**
| Key | Action |
|-----|--------|
| `Ctrl+k` / `Ctrl+j` | Previous / next item |
| `Ctrl+b` / `Ctrl+f` | Scroll docs |
| `Ctrl+Space` | Trigger completion |
| `Ctrl+e` | Abort |
| `<CR>` | Confirm selection (auto-select first) |

### Navigation & Search

| Plugin | Keybinding | Action |
|--------|-----------|--------|
| **Telescope** | `<leader>ff` | Find files |
| | `<leader>fw` | Live grep |
| | `<leader>fc` | Grep word under cursor |
| | `Ctrl+k/j` (inside) | Move selection |
| | `Ctrl+q` (inside) | Send to quickfix |
| | `Ctrl+t` (inside) | Open in Trouble |
| **mini.move** | `Alt+hjkl` | Move selected lines/blocks |

### Editing

| Plugin | What it does |
|--------|-------------|
| **nvim-autopairs** | Auto-close brackets, quotes |
| **nvim-surround** | `ys`/`ds`/`cs` surround text objects |
| **todo-comments** | Highlights `TODO:`, `FIXME:`, `HACK:`, etc. |
| **bufdelete** | Safe buffer deletion preserving window layout |
| **conform.nvim** | GDScript formatting (`gdscript-formatter` + `gdformat`) |

### Treesitter
- 22 languages installed: json, javascript, typescript, tsx, yaml, html, css, prisma, markdown, svelte, graphql, bash, lua, vim, dockerfile, gitignore, query, vimdoc, c, cpp, haskell, gdscript, gdshader, godot_resource
- **Incremental selection:** `Ctrl+Space` to init/expand, `Backspace` to shrink
- Auto-close/rename HTML tags via nvim-ts-autotag
- Indent overrides disabled (uses native indentation)

### Folding — nvim-ufo
Modern fold UI with promise-async dependency.

### Trouble
Diagnostics list panel with clangd Qt flag filtering (`-mno-direct-extern-access`).

### vim-tmux-navigator
Seamless `Ctrl+hjkl` navigation between tmux panes and Neovim splits.

---

## LSP (`lua/salar/plugins/lsp/`)

Uses the new `vim.lsp.config()` API (Neovim 0.11+).

### Mason-managed servers (auto-installed)
TypeScript (ts_ls), HTML, CSS, Tailwind, Svelte, Lua, GraphQL, Emmet, Pyright, Clangd, Rust Analyzer

### Per-server configuration

| Server | Language(s) | Key settings |
|--------|------------|-------------|
| **ts_ls** | TS, TSX, JS, JSX | Standard capabilities |
| **clangd** | C, C++, ObjC, ObjC++ | Background index, clang-tidy, C++23 fallback flags; filters Qt unknown-argument diagnostics |
| **lua_ls** | Lua | LuaJIT runtime, `vim` global, Neovim runtime library |
| **rust_analyzer** | Rust | Type inlay hints on, all other hints off |
| **tinymist** | Typst | `.git` root marker |
| **hls** | Haskell | Conditional on `haskell-language-server-wrapper` existing; supports `.hs`, `.lhs`, `.cabal` |
| **gdscript** | GDScript | Standard LSP |
| **gdshader_lsp** | Godot shaders | Conditional on `gdshader-lsp` binary |

### LSP buffer keymaps (set on `LspAttach`)

| Key | Action |
|-----|--------|
| `gR` | Telescope LSP references |
| `gD` | Go to declaration |
| `gd` | Go to definition |
| `gi` | Telescope implementations |
| `gt` | Telescope type definitions |
| `<leader>ca` | Code actions |
| `<leader>rn` | Smart rename |
| `<leader>D` | Telescope document diagnostics |
| `<leader>d` | Floating diagnostic |
| `[d` / `]d` | Previous / next diagnostic |
| `K` | Hover |
| `<leader>rs` | LSP restart |

### Diagnostics
- **Signs:** Error (circle-x), Warn (triangle-exclamation), Hint (gear), Info (info-circle)
- **Virtual text:** bullet prefix, 2-char spacing, severity sort
- Inlay hints disabled for C/C++ and header files
- Semantic tokens disabled globally

### Auto-format on save
- **C/C++:** clangd via `vim.lsp.buf.format`
- **Typst:** typstyle via conform.nvim

---

## DAP — Debugging

Fully configured for C/C++/Rust debugging with lldb-dap or codelldb.

### Keybindings

| Key | Action |
|-----|--------|
| `<leader>dc` | Continue / launch |
| `<leader>db` | Toggle breakpoint |
| `<leader>ds` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dr` | Restart debug session |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI panel |
| `<leader>dw` | Add watch expression |
| `<leader>dW` | Remove watch |
| `<leader>dC` | Clear all watches |

### Debug configurations
- **Launch** — auto-detects binary (same name as current file, in `build/`, `bin/`, `out/`, etc.)
- **Launch with args** — prompts for program arguments
- **Attach to process** — `pick_process` UI

### DAP UI
Left panel (40 cols) with scopes, breakpoints, stacks, watches. Auto-opens/closes on debug start/stop.

### DAP Virtual Text
Inline variable values with highlighted changed variables and stop reason.

---

## Obsidian (`lua/salar/core/obsidian.lua` + `lua/salar/plugins/obsidian.lua`)

### Workspace detection
- Checks `vim.g.obsidian_workspaces` first
- Falls back to env vars: `OBSIDIAN_VAULT_PERSONAL` (~/vaults/personal), `OBSIDIAN_VAULT_WORK` (~/vaults/work)
- Auto-detects vault from `.obsidian` directory in parent tree
- Deduplicates workspaces by path

### Configuration
- Notes stored in `notes/` subdirectory
- Daily notes in `notes/dailies/` with format `YYYY-MM-DD`, aliases like "Friday, July 24, 2026"
- Note IDs: `YYYYMMDD-HHMM-{slug-title}`
- Wiki-style links, sorted by modification date (newest first)
- Telescope as picker (`Ctrl+x` new note, `Ctrl+l` insert link)
- Images saved to `assets/imgs/`
- Daily template: auto-detects `templates/daily.md`

### Template substitutions
Custom substitutions available in templates:
- `{{date:YYYY-MM-DD}}` — Obsidian-style date format (translated to Lua strftime)
- `{{time:HH:mm}}` — Obsidian-style time format
- `{{weekday}}` — day name (e.g. "Friday")
- `{{cursor}}` — placeholder `<++>`

### Markdown buffer settings
- Wrap on, linebreak, conceallevel=2, textwidth=100, spell off

### Obsidian keybindings

| Key | Action |
|-----|--------|
| `<leader>ob` | Backlinks |
| `<leader>od` | Today's daily note |
| `<leader>ol` | Note links (outgoing) |
| `<leader>oo` | Open in Obsidian app |
| `<leader>oq` | Quick switch |
| `<leader>os` | Search notes |
| `<leader>ot` | Insert template |
| `<leader>oT` | Table of contents |
| `<leader>om` | Toggle markdown render |
| `<leader>oc` | Toggle checkbox (buffer-local) |
| `gf` | Follow wiki link (buffer-local) |
| `<CR>` | Smart action on link (buffer-local) |

---

## Godot Integration (`lua/salar/core/godot.lua`)

On `VimEnter`, `DirChanged`, `BufReadPost`, and `BufNewFile`:
- Detects if inside a Godot project (looks upward for `project.godot`)
- If found, starts a Neovim server at `{project_root}/godothost` — the socket Godot's editor plugin connects to for embedded Neovim editing

---

## Typst Integration (`lua/salar/tools/init.lua`)

- Auto-compiles `.typ` files to PDF on save (background `typst compile`)
- `:TypstPreview` — opens the compiled PDF in Zathura
- LSP via tinymist; formatting via typstyle

---

## C++ Tooling (`lua/salar/tools/`)

### 1. Include Formatter (`include_formatter.lua`)

Runs automatically on `BufWritePre` for C/C++ files.

**What it does:**
- Parses the first contiguous `#include` block and reorganizes it into sections:
  1. Third-party angle-bracket includes (sorted alphabetically)
  2. Standard library angle-bracket includes (sorted)
  3. Quoted includes grouped by directory, with self-include first
- Deduplicates within the block
- Comprehensive allow-list of ~60 C/C++ standard library headers

**Opt-out per file:** add `// noincludeformat` as the first non-blank/non-comment line.

### 2. Include Renamer (`include_rename.lua`)

Triggered on NvimTree's `NodeRenamed` event.

**What it does:**
- When a C/C++ file is renamed, attempts LSP `workspace/willRenameFiles` first
- Falls back to text-based rewriting: scans project for `#include` directives and updates paths
- Smart suffix matching and basename-only replacement (when unambiguous)
- Reports how many files were updated

### 3. Skeleton Generator (`skeleton.lua`) — `:Skel`

Generates boilerplate based on file type:

- **Header files** (`.h`, `.hpp`, `.hh`, `.hxx`):
  ```cpp
  #pragma once

  namespace ProjectName {
  class FileName {
  public:

  private:
  };

  }
  ```
- **Source files** (`.cpp`, `.cc`, `.cxx`):
  ```cpp
  #include "FileName.h"

  namespace ProjectName {

  }
  ```
- **main.cpp**:
  ```cpp
  #include <iostream>

  int main() {
      std::cout << "Hello, world!\n";
      return 0;
  }
  ```

Namespace derived from project root directory name (snake_case → PascalCase).
For `.cpp` files, auto-detects the matching header using:
- Same-directory lookup
- `include/`, `src/`, `source/` convention directories
- `compile_commands.json` include paths
- Scoring system (same dir: +100, include/: +80, relative path match: +120, shorter path preferred)

### 4. C++ Definition Extractor (`cpp_extract.lua`)

Two commands for moving inline definitions from headers to `.cpp`:

**`:CppExtractDefinitions`** — extracts ALL non-template member function definitions from the class under cursor:
- Uses tree-sitter to parse C++ AST
- Replaces definitions with declarations (strips `static`, `inline`, `virtual`, `friend`, `explicit`, `override`)
- Appends definitions to matching `.cpp` file, preserving namespace structure
- Detects and avoids duplicates
- Skips template functions (which must stay in headers)

**`:CppExtractFunctionDefinition`** — extracts a single function definition:
- Works for both member functions (triggers class-level extraction) and free functions
- Same deduplication and namespace handling

---

## Commands Reference

### Theme
| Command | Description |
|---------|-------------|
| `:Theme [name]` | Select or set a theme (with tab-completion) |
| `:ThemeNext` | Cycle to next theme |
| `:ThemePrev` | Cycle to previous theme |

### C++ Tools
| Command | Description |
|---------|-------------|
| `:Skel` | Generate C++ boilerplate for current file |
| `:CppExtractDefinitions` | Extract all inline member definitions from class under cursor to .cpp |
| `:CppExtractFunctionDefinition` | Extract single function definition under cursor to .cpp |

### Typst
| Command | Description |
|---------|-------------|
| `:TypstPreview` | Open compiled PDF in Zathura |

### Help
| Command | Description |
|---------|-------------|
| `:Helpp` | Open this README in Neovim |

---

## Complete Plugin Inventory

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| plenary.nvim | Lua utility library |
| telescope.nvim | Fuzzy finder |
| telescope-fzf-native | Native FZF sorter |
| nvim-tree.lua | File explorer |
| bufferline.nvim | Buffer tab bar |
| lualine.nvim | Statusline |
| alpha-nvim | Start screen dashboard |
| nvim-cmp | Completion engine |
| LuaSnip | Snippet engine |
| friendly-snippets | Pre-built snippets |
| lspkind.nvim | Completion pictograms |
| nvim-treesitter | Syntax highlighting |
| nvim-ts-autotag | Auto-close HTML tags |
| nvim-autopairs | Auto-close brackets |
| nvim-surround | Surround text objects |
| nvim-lspconfig | LSP configuration |
| mason.nvim | LSP installer |
| mason-lspconfig.nvim | Mason/LSP bridge |
| neodev.nvim | Lua LSP enhancements |
| nvim-lsp-file-operations | LSP-aware file ops |
| conform.nvim | Formatter (GDScript/Typst) |
| nvim-dap | Debug Adapter Protocol |
| nvim-dap-ui | DAP side panel |
| nvim-dap-virtual-text | Inline debug values |
| nvim-nio | Async I/O |
| trouble.nvim | Diagnostics list panel |
| todo-comments.nvim | Highlight TODO/FIXME |
| dressing.nvim | Improved vim.ui |
| snacks.nvim | Small utilities collection |
| drop.nvim | Dashboard animation |

| satellite.nvim | Scrollbar |
| mini.move | Smart text movement |
| nvim-ufo | Modern fold UI |
| presence.nvim | Discord Rich Presence |
| obsidian.nvim | Obsidian note-taking |
| render-markdown.nvim | Live markdown rendering |
| rndr.nvim | 3D model viewer |
| vim-tmux-navigator | Tmux pane navigation |
| bufdelete.nvim | Safe buffer deletion |
| nvim-colorizer.lua | Color code highlighter |
