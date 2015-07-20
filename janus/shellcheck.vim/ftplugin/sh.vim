set makeprg=shellcheck\ -f\ gcc\ %
au BufWritePost * :silent make | redraw!
