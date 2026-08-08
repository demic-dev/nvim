-- Every lua/plugins/**/*.lua is a self-contained feature: it declares its own
-- plugins with vim.pack.add and configures them. Renaming a file to "-X.lua"
-- disables that feature.
local root = vim.fn.stdpath("config") .. "/lua/plugins"
local files = vim.fn.globpath(root, "**/*.lua", false, true)
table.sort(files)

for _, file in ipairs(files) do
  if not file:match("%-X%.lua$") then
    local module = file:sub(#root + 2, -5):gsub("/", ".")
    local ok, err = pcall(require, "plugins." .. module)
    if not ok then
      vim.notify(("plugins.%s failed: %s"):format(module, err), vim.log.levels.ERROR)
    end
  end
end
