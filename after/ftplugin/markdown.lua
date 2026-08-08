vim.opt_local.conceallevel = 2 -- render-markdown hides the markup it draws

-- Continue bullet and numbered lists on <CR> and o.
vim.opt_local.comments = "b:- [ ],b:- [x],b:-,b:*,b:+,b:>"
vim.opt_local.formatlistpat = [[^\s*\d\+[\]:.)}\t ]\s*]]
vim.opt_local.formatoptions:append("ron")
vim.opt_local.formatoptions:remove("t")
