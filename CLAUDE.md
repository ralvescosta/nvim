# Neovim Config — Claude Rules

## Architecture

```
init.lua                         ← entry point; loads options, mappings, bootstraps Lazy
lua/kickstart/options.lua        ← vim options + autocmds
lua/kickstart/mappings.lua       ← global keymaps (leader = Space)
lua/kickstart/plugins/           ← 18 base plugins (treat as read-only unless fixing a bug)
lua/custom/plugins/              ← personal plugins; all new work goes here
lua/custom/plugins/init.lua      ← empty barrel, required by Lazy's import scan
```

`init.lua` imports both trees:
```lua
{ import = 'kickstart.plugins' },
{ import = 'custom.plugins' },
```

**Rule:** prefer `lua/custom/plugins/` for all additions. Touch `kickstart/` only to fix
a bug or upgrade a base plugin — never to add new functionality.

---

## Adding a Plugin

Create `lua/custom/plugins/<name>.lua` returning a Lazy spec:

```lua
return {
  'author/plugin-name',
  event = 'VeryLazy',           -- lazy-load trigger; omit only for plugins needed at startup
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},                    -- preferred over config = function() when setup() takes a table
  keys = {                      -- declare keymaps here so which-key picks them up
    { '<leader>xx', '<cmd>DoThing<cr>', desc = 'Do [T]hing' },
  },
}
```

Lazy-loading triggers in order of preference: `keys`, `ft`, `cmd`, `event = 'VeryLazy'`.
Only use `lazy = false` for plugins that must run at startup (e.g., colorscheme).

---

## Adding an LSP Server

File: `lua/kickstart/plugins/lspconfig.lua`

1. Add the mason package name to `ensure_installed` in the `mason-tool-installer` block.
2. Add the lspconfig server name to the `servers` table:

```lua
servers = {
  your_ls = {
    settings = { ... },
  },
}
```

The handler loop at the bottom of `config = function()` automatically calls
`lspconfig[server].setup()` for every entry in `servers`.

**Exception — Rust:** `rust_analyzer` is intentionally absent. It is managed entirely
by `rustaceanvim` (`lua/custom/plugins/rustaceanvim.lua`). Do not add it to
mason-lspconfig handlers.

Configured servers: `clangd`, `gopls`, `pyright`, `ts_ls`, `terraformls`, `yamlls`,
`dockerls`, `helm_ls`, `buf_ls`, `html`, `cssls`, `lua_ls`.

---

## Adding a Formatter

File: `lua/kickstart/plugins/conform.lua`

```lua
-- 1. formatters_by_ft table
formatters_by_ft = {
  yourfiletype = { 'your_formatter' },
}
-- 2. mason ensure_installed list (if Mason can install it)
ensure_installed = { ..., 'your-formatter-mason-name' }
```

Current formatters: `stylua`, `gofmt`, `goimports-reviser`, `golines`, `clippy`,
`taplo`, `buf`, `prettier`, `terraform_fmt`, `dockerfmt`.

---

## Adding a Linter

File: `lua/kickstart/plugins/lint.lua`

```lua
linters_by_ft = {
  yourfiletype = { 'your_linter' },
}
```

Add the mason package to `mason-tool-installer` in `lspconfig.lua` if applicable.
Current linters: `cspell`, `markdownlint`.

---

## Adding Treesitter Parsers

File: `lua/kickstart/plugins/treesitter.lua`

```lua
ensure_installed = { ..., 'your_language' }
```

---

## Keybinding Conventions

- Leader: `Space`
- Keymaps in plugin files use the `keys = {}` Lazy spec field (preferred) or
  `vim.keymap.set` inside `config`.
- Always include a `desc` string. Use `[B]racket` notation for the mnemonic.
- LSP keymaps belong in the `LspAttach` autocmd in `lspconfig.lua`.

Key groups in use:
| Prefix | Group |
|--------|-------|
| `<leader>s` | Search (Telescope) |
| `<leader>d` | Document / Debug |
| `<leader>r` | Rename / Run test |
| `<leader>c` | Code action |
| `<leader>t` | Test (neotest) / Toggle |

---

## Autocommand Conventions

Always use a named augroup with `clear = true`:

```lua
vim.api.nvim_create_autocmd('EventName', {
  group = vim.api.nvim_create_augroup('custom-descriptive-group', { clear = true }),
  callback = function(event) ... end,
})
```

Use `custom-` prefix for new groups. Existing: `kickstart-lsp-attach`,
`kickstart-lsp-highlight`, `kickstart-lsp-detach`.

---

## Verification

```bash
# Syntax/load check — exit 0 on success
nvim --headless "+Lazy! sync" +qa 2>&1 | head -30

# Check a specific plugin loaded
nvim --headless -c "lua print(require('plugin-name'))" +qa 2>&1
```

Inside nvim:
- `:checkhealth` — broad health check
- `:Lazy` — plugin state (installed, loaded, errors)
- `:LspInfo` — LSP attached to buffer
- `:ConformInfo` — formatters for filetype
- `:Mason` — installed tools

Run `nvim --headless "+Lazy! sync" +qa` after adding a new plugin entry. Not needed for
editing existing configs — Lazy hot-reloads specs.

---

## Do Not Touch

- `lazy-lock.json` — managed by Lazy; only commit after intentional `:Lazy update`
- LSP keymaps in `lspconfig.lua` `LspAttach` block — shared across all servers by design
- The `rust_analyzer` exclusion in mason-lspconfig handlers
- `nvim-dap-go` env vars (`GOPRIVATE`, `ENVIRONMENT`, `OTEL_*`, `AWS_*`) — org-specific
