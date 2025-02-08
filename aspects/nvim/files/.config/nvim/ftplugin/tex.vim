function! OpenSync() abort
  let l:bind = printf(
        \ "--bind 'focus:execute-silent(zathura --synctex-forward {1}:1:\"%s\" \"%s\")'",
        \ b:vimtex.tex,
        \ b:vimtex.compiler.get_file('pdf')
        \)

  call vimtex#fzf#run('ctli', {
        \ 'up': '90%',
        \ 'sink':  function('vimtex#fzf#open_selection'),
        \ 'options': '-d "#####" --with-nth=3.. --ansi ' . l:bind
        \})
endfunction

function! SearchEnvironments(env) abort
  " Get the root directory of the LaTeX project using Vimtex
  let l:project_root = vimtex#context#get().root

  " Ensure a valid project root is found
  if empty(l:project_root)
    echo "No LaTeX project root found. Is Vimtex loaded?"
    return
  endif

  " Grep for the specific environment in all .tex files in the project
  let l:results = systemlist('rg -n -g "*.tex" "\\\\begin{' . a:env . '}" ' . l:project_root)

  " Check if there are results
  if empty(l:results)
    echo "No matches found for environment '" . a:env . "' in the project."
    return
  endif

  " Pass results to fzf
  let l:selected = fzf#run(fzf#wrap({
        \ 'source': l:results,
        \ 'sink': function('s:OpenLocation'),
        \ 'options': '--preview "echo {} | cut -d: -f2-"'
        \ }))

endfunction

function! s:OpenLocation(line) abort
  " Parse the selected line
  let l:parts = split(a:line, ':', 3)
  if len(l:parts) < 2
    return
  endif

  " Get the filename and line number
  let l:filename = l:parts[0]
  let l:linenr = l:parts[1]

  " Open the file and jump to the line
  execute 'edit ' . l:filename
  execute l:linenr
endfunction

" Command to search for a specific environment across the LaTeX project
command! -nargs=1 SearchEnv call SearchEnvironments(<q-args>)
