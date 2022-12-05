local keymap = vim.keymap

-- do not copy char with x
keymap.set('n', 'x', '"_x')

-- increment/decrement a count
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- delete in backwards
keymap.set('n', 'dw', 'vb"_d')

-- select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- new tab
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })

-- split window
-- horizontal split
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
-- vertical split
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })

-- move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sl', '<C-w>l')
keymap.set('', 'sj', '<C-w>j')

-- resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

