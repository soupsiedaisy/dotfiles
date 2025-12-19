local resession = require('resession')

resession.setup({})

vim.keymap.set('n', '<leader>rs', resession.save, { desc = 'Session save (resession)' })
vim.keymap.set('n', '<leader>rl', resession.load, { desc = 'Session load (resession)' })
vim.keymap.set('n', '<leader>rd', resession.delete, { desc = 'Session delete (resession)' })
