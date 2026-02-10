# NeoVim Configuration

Modern NeoVim configuration using Lazy.nvim plugin manager.

## Overview

This is a pure NeoVim configuration that replaces the old vim/nvim hybrid setup. The old configuration has been archived in `/home/user/.config/dotter/common/vim/__deprecated/nvim.xlink/`.

### Key Changes

- **Plugin Manager**: Migrated from vim-plug to Lazy.nvim
- **Language**: Configuration is now primarily in Lua (with VimScript removed)
- **Focus**: Pure NeoVim features (LSP, Treesitter, modern Lua ecosystem)
- **Performance**: Lazy loading for better startup time

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Lazy.nvim bootstrap
│   │   ├── options.lua        # Editor options
│   │   ├── keymaps.lua        # Key bindings
│   │   └── autocmds.lua       # Autocommands
│   └── plugins/
│       ├── ui.lua             # UI plugins (gruvbox, lualine, nvim-tree)
│       ├── editor.lua         # Editor enhancements (surround, commentary, etc.)
│       ├── navigation.lua     # Navigation (flash, telescope)
│       ├── git.lua            # Git integration (fugitive, gitsigns)
│       ├── lsp.lua            # LSP configuration
│       ├── completion.lua     # Completion (nvim-cmp)
│       ├── treesitter.lua     # Treesitter syntax
│       ├── snippets.lua       # UltiSnips configuration
│       └── languages.lua      # Language-specific plugins
├── after/
│   └── ftplugin/              # Filetype-specific configs
│       └── python.vim
└── UltiSnips/                 # Custom snippets
```

## Installation

1. **Symlink configuration via dotter**:
   ```bash
   cd ~/.config/dotter
   dotter deploy
   ```

2. **Open NeoVim and install plugins**:
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install on first run and install all plugins.

3. **Install language servers**:
   In NeoVim:
   ```vim
   :Mason
   ```
   Language servers (pyright, tsserver, gopls, rust_analyzer, lua_ls) are configured to auto-install.

## Key Features

### LSP Support
- **Mason**: Automatic language server management
- **Configured servers**: Python (pyright), TypeScript (tsserver), Go (gopls), Rust (rust_analyzer), Lua (lua_ls)
- **Key bindings** (when LSP is active):
  - `gd` - Go to definition
  - `gD` - Go to declaration
  - `K` - Hover documentation
  - `gi` - Go to implementation
  - `gr` - List references
  - `<space>rn` - Rename symbol
  - `<space>ca` - Code actions
  - `<space>f` - Format document

### Completion
- **nvim-cmp**: Modern completion engine
- **Sources**: LSP, buffer, path, cmdline, UltiSnips
- **Key bindings**:
  - `<C-Space>` - Trigger completion
  - `<CR>` - Confirm selection
  - `<C-e>` - Abort completion
  - `<C-b>/<C-f>` - Scroll documentation

### Navigation
- **Telescope**: Fuzzy finder
  - `ff` - Find files
  - `fg` - Live grep
  - `fw` - Grep word under cursor
  - `fb` - List buffers
  - `fj` - Jump list
  - `fr` - LSP references
  - `fd` - LSP definitions
  - `fT` - Telescope builtin pickers
- **Flash.nvim**: Quick motion
  - `s` - Flash jump

### File Explorer
- `<leader>n` - Toggle nvim-tree

### Git Integration
- **Fugitive**: Git commands (`:Git`, `:Gdiffsplit`, etc.)
- **Gitsigns**: Git hunks in gutter
  - `]c` / `[c` - Next/previous hunk
  - `<leader>hs` - Stage hunk
  - `<leader>hr` - Reset hunk
  - `<leader>hp` - Preview hunk
  - `<leader>hb` - Blame line
  - `<leader>tb` - Toggle blame

### Snippets
- **UltiSnips**: Snippet engine
- **Key bindings**:
  - `<C-j>` - Jump forward
  - `<C-k>` - Jump backward
- Custom snippets in `~/.config/nvim/UltiSnips/`

### Editor Enhancements
- **vim-surround**: Surround text objects
- **vim-commentary**: Toggle comments with `gc`
- **nvim-autopairs**: Auto-close brackets
- **Tabular**: Align text (`:Tabularize`)
- **targets.vim**: Additional text objects
- **vim-indent-object**: Select by indentation level

## General Key Bindings

### Leader Keys
- `<Space>` - Leader
- `\` - Local leader

### Tabs
- `tn` / `tp` - Next/previous tab
- `te` - New tab
- `to` - Close other tabs
- `<C-w>1` to `<C-w>9` - Jump to tab 1-9

### Search
- `n` / `N` - Next/previous search (auto-enables hlsearch)
- `<leader>'` - Toggle hlsearch
- `<CR>` - Clear hlsearch in normal mode

### Misc
- `<leader>v` / `<leader>V` - Select recently changed text (visual/line)
- `<leader><leader>m` - Change directory to current file
- `<leader><leader>q` - Toggle quickfix list

### Terminal
- `<C-\><C-[>` - Exit terminal mode

## Plugin Migration Reference

### Replaced Plugins
| Old (vim-plug) | New (Lazy.nvim) | Reason |
|----------------|-----------------|--------|
| scrooloose/nerdtree | nvim-tree/nvim-tree.lua | Native Lua, better performance |
| itchyny/lightline.vim | nvim-lualine/lualine.nvim | Native Lua, more features |
| Lokaltog/vim-easymotion | folke/flash.nvim | Modern, faster |
| Raimondi/delimitMate | windwp/nvim-autopairs | Better nvim integration |
| kien/ctrlp.vim | nvim-telescope/telescope.nvim | Modern fuzzy finder |
| nonlogicaldev/vim.color.gruvbox | ellisonleao/gruvbox.nvim | Native Lua version |

### Kept Plugins
- tpope/vim-surround
- tpope/vim-commentary
- tpope/vim-fugitive
- tpope/vim-repeat
- SirVer/ultisnips
- honza/vim-snippets
- sheerun/vim-polyglot
- lewis6991/gitsigns.nvim
- nvim-telescope/telescope.nvim
- neovim/nvim-lspconfig
- williamboman/mason.nvim
- hrsh7th/nvim-cmp
- nvim-treesitter/nvim-treesitter
- wellle/targets.vim
- michaeljsmith/vim-indent-object
- vim-scripts/bufkill.vim
- godlygeek/tabular
- ojroques/vim-oscyank
- lepture/vim-jinja
- rizzatti/dash.vim

## Customization

### Adding New Plugins
Create a new file in `lua/plugins/` or add to an existing file:

```lua
return {
  {
    "username/plugin-name",
    event = "VeryLazy",  -- or cmd, keys, ft, etc.
    config = function()
      -- plugin configuration
    end,
  },
}
```

### Modifying Options
Edit `lua/config/options.lua`

### Adding Key Bindings
Edit `lua/config/keymaps.lua`

### Adding Autocommands
Edit `lua/config/autocmds.lua`

## Troubleshooting

### Plugins Not Loading
```vim
:Lazy
:Lazy sync
```

### LSP Not Working
```vim
:LspInfo
:Mason
```

### Check for Errors
```vim
:checkhealth
:messages
```

## Regular Vim

For systems without NeoVim or minimal editing, a simple `.vimrc` is now available:
- Location: `~/.config/dotter/common/vim/.vimrc`
- No plugins, essential settings only
- Auto-deployed via dotter

## Migration Date

This configuration was migrated on 2026-02-09 from the old vim-plug based setup.

## References

- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [NeoVim Documentation](https://neovim.io/doc/)
- [Old Configuration](../vim/__deprecated/nvim.xlink/)
