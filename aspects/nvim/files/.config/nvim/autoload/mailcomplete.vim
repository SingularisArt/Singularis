function! mailcomplete#Complete(findstart, base)
  if a:findstart == 1
    let line = getline('.')
    let idx = col('.')
    while idx > 0
      let idx -= 1
      let c = line[idx]
      if c == ':' || c == '>'
        return idx + 2
      else
        continue
      endif
    endwhile
    return idx
  else
    if exists("g:goobookrc")
      let goobook="goobook -c " . g:goobookrc
    else
      let goobook="goobook"
    endif
    let res=system(goobook . ' query ' . shellescape(a:base))
    if v:shell_error
      return []
    else
      return mailcomplete#Format(mailcomplete#Trim(res))
    endif
  endif
endfunc

function! mailcomplete#Trim(res)
  let trim="sed '/^$/d' | grep -v '(group)$' | cut -f1,2"
  return split(system(trim, a:res), '\n')
endfunc

function! mailcomplete#Format(contacts)
  let contacts=map(copy(a:contacts), "split(v:val, '\t')")
  let ret=[]
  for [email, name] in contacts
    call add(ret, printf("%s <%s>", name, email))
  endfor
  return ret
endfunc
