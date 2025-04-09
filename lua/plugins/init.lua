-- This file serves as an entry point for all plugin specs
-- All files in the plugins directory will be automatically loaded by lazy.nvim

return {
  require("plugins.text_editing.latex"),
  require("plugins.text_editing.markdown"),
  require("plugins.org")
}