return {
  cmd = { 'clangd', '--background-index', '--completion-style=detailed' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
}
