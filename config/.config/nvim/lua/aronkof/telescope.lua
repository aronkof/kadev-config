require'telescope'.setup({
    defaults = {
        file_ignore_patterns = { "^./.git/", "./node_modules/*", "./vendor/*" },
        mappings = {
            i = {
                ["<esc>"] = require"telescope.actions".close
            }
        }
    }
})
