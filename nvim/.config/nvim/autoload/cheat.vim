" List of all languages neovim supports by default
let s:languages = [
    \ '2html', '8th', 'HGAnnotate', 'PKGBUILD', 'a2ps', 'a65',
    \ 'aap', 'abap', 'abaqus', 'abc', 'abel', 'acedb', 'ada', 'aflex', 'ahdl', 'aidl',
    \ 'ale-fix-suggest', 'ale-preview', 'ale-preview-selection ', 'alsaconf', 'amiga',
    \ 'aml', 'ampl', 'ant', 'antlr', 'apache', 'apachestyle', 'aptconf', 'arch',
    \ 'arduino', 'art', 'asciidoc', 'asm', 'asm68k', 'asmh8300', 'asn', 'aspperl',
    \ 'aspvbs', 'asterisk ', 'asteriskvm', 'atlas', 'autodoc', 'autohotkey', 'autoit',
    \ 'automake', 'ave', 'avra', 'awk', 'ayacc', 'b', 'baan', 'bash', 'basic', 'bc',
    \ 'bdf', 'bib', 'bindzone', 'blank', 'bsdl', 'bst', 'btm' , 'bzl', 'bzr', 'c',
    \ 'cabal', 'cabalconfig', 'cabalproject', 'calendar', 'catalog', 'cdl',
    \ 'cdrdaoconf', 'cdrtoc', 'cf', 'cfg', 'ch', 'chaiscript', 'change', 'changelog',
    \ 'chaskell', 'cheetah', ' chicken', 'chill', 'chordpro', 'cl', 'clean',
    \ 'clipper', 'clojure', 'cmake', 'cmod', 'cmusrc', 'cobol', 'coco', 'colortest',
    \ 'conaryrecipe', 'conf', 'config', 'context', 'cpp', 'crm', 'crontab', 'cs',
    \ 'csc', 'csdl', 'csh', 'csp', 'css', 'cterm', 'ctrlh', 'cucumber', 'cuda',
    \ 'cupl', 'cuplsim', 'cvs', 'cvsrc', 'cweb', 'cynlib', 'cynpp', 'd', 'dart',
    \ 'datascript', 'dcd', 'dcl', 'debchangelo g', 'debcontrol', 'debcopyright',
    \ 'debsources', 'def', 'denyhosts', 'desc', 'desktop', 'dictconf', 'dictdconf',
    \ 'diff', 'dircolors', 'dirpager', 'diva', 'django', 'dns', 'dnsmasq', 'docbk',
    \ 'docb ksgml', 'docbkxml', 'dockerfile', 'dosbatch', 'dosini', 'dot', 'doxygen',
    \ 'dracula', 'dsl', 'dtd', 'dtml', 'dtrace', 'dts', 'dune', 'dylan', 'dylanintr',
    \ 'dylanlid', 'ecd', 'edif', 'eiffel', 'elf ', 'elinks', 'elm', 'elmfilt',
    \ 'erlang', 'eruby', 'esmtprc', 'esqlc', 'esterel', 'eterm', 'euphoria3',
    \ 'euphoria4', 'eviews', 'exim', 'expect', 'exports', 'falcon', 'fan', 'fasm',
    \ 'fdcc', 'fetchm ail', 'fgl', 'flexwiki', 'foam', 'focexec', 'form', 'forth',
    \ 'fortran', 'foxpro', 'fpcmake', 'framescript', 'freebasic', 'fstab', 'fugitive',
    \ 'fugitiveblame', 'fvwm', 'fvwm2m4', 'gdb', 'gdmo', 'g edcom', 'gift', 'git',
    \ 'gitcommit', 'gitconfig', 'gitolite', 'gitrebase', 'gitsendemail', 'gkrellmrc',
    \ 'gnash', 'gnuplot', 'go', 'godoc', 'gp', 'gpg', 'gprof', 'grads', 'gretl',
    \ 'groff', 'groovy' , 'group', 'grub', 'gsp', 'gtkrc', 'haml', 'hamster',
    \ 'haskell', 'haste', 'hastepreproc', 'hb', 'help', 'help_ru', 'hercules', 'hex',
    \ 'hgcommit', 'hitest', 'hog', 'hollywood', 'hostconf', 'hostsa ccess', 'html',
    \ 'htmlcheetah', 'htmldjango', 'htmlm4', 'htmlos', 'ia64', 'ibasic', 'icemenu',
    \ 'icon', 'idl', 'idlang', 'indent', 'inform', 'initex', 'initng', 'inittab',
    \ 'ipfilter', 'ishd', 'iss' , 'ist', 'j', 'jal', 'jam', 'jargon', 'java',
    \ 'javacc', 'javascript', 'javascriptreact', 'jess', 'jgraph', 'jovial',
    \ 'jproperties', 'json', 'jsp', 'kconfig', 'kivy', 'kix', 'kscript', 'kwt',
    \ 'lace', 'latte', 'ld', 'ldapconf', 'ldif', 'less', 'lex', 'lf', 'lftp',
    \ 'lhaskell', 'libao', 'lifelines', 'lilo', 'limits', 'liquid', 'lisp', 'lite',
    \ 'litestep', 'logcheck', 'loginaccess', 'logindefs ', 'logtalk', 'lotos', 'lout',
    \ 'lpc', 'lprolog', 'lscript', 'lsl', 'lss', 'lua', 'lynx', 'm3build', 'm3quake',
    \ 'm4', 'mail', 'mailaliases', 'mailcap', 'make', 'mallard', 'man', 'manconf',
    \ 'manual', 'maple', 'markdown', 'masm', 'mason', 'master', 'matlab', 'maxima',
    \ 'mel', 'meson', 'messages', 'mf', 'mgl', 'mgp', 'mib', 'mix', 'mma', 'mmix',
    \ 'mmp', 'modconf', 'model', 'modsim3', 'modula2' , 'modula3', 'monk', 'moo',
    \ 'mp', 'mplayerconf', 'mrxvtrc', 'msidl', 'msmessages', 'msmtp', 'msql', 'mupad',
    \ 'murphi', 'mush', 'muttrc', 'mysql', 'n1ql', 'named', 'nanorc', 'nasm',
    \ 'nastran', 'na tural', 'ncf', 'neomuttrc', 'netrc', 'netrw', 'ninja',
    \ 'nosyntax', 'nqc', 'nroff', 'nsis', 'obj', 'objc', 'objcpp', 'ocaml', 'occam',
    \ 'omnimark', 'opam', 'openroad', 'opl', 'ora', 'pamconf', 'pam env', 'papp',
    \ 'pascal', 'passwd', 'pbtxt', 'pcap', 'pccts', 'pdf', 'perl', 'pf', 'pfmain',
    \ 'php', 'phtml', 'pic', 'pike', 'pilrc', 'pine', 'pinfo', 'plaintex', 'pli',
    \ 'plm', 'plp', 'plsql', 'po', 'pod', 'poke', 'postscr', 'pov', 'povini', 'ppd',
    \ 'ppwiz', 'prescribe', 'privoxy', 'procmail', 'progress', 'prolog', 'promela',
    \ 'proto', 'protocols', 'ps1', 'ps1xml', 'psf', 'psl', 'ptcap', 'pul lrequest',
    \ 'purifylog', 'pyrex', 'python', 'qf', 'quake', 'r', 'racc', 'radiance', 'ragel',
    \ 'raku', 'raml', 'ratpoison', 'rc', 'rcs', 'rcslog', 'readline', 'rebol',
    \ 'redif', 'registry', 'rego', ' remind', 'resolv', 'reva', 'rexx', 'rhelp',
    \ 'rib', 'rmd', 'rnc', 'rng', 'rnoweb', 'robots', 'rpcgen', 'rpl', 'rrst', 'rst',
    \ 'rtf', 'ruby', 'rust', 'samba', 'sas', 'sass', 'sather', 'sbt', 'scala' ,
    \ 'scheme', 'scilab', 'screen', 'scss', 'sd', 'sdc', 'sdl', 'sed', 'sendpr',
    \ 'sensors', 'services', 'setserial', 'sexplib', 'sgml', 'sgmldecl', 'sgmllnx',
    \ 'sh', 'sicad', 'sieve', 'sil', 'simula', 'sinda', 'sindacmp', 'sindaout',
    \ 'sisu', 'skill', 'sl', 'slang', 'slice', 'slpconf', 'slpreg', 'slpspi',
    \ 'slrnrc', 'slrnsc', 'sm', 'smarty', 'smcl', 'smil', 'smith', 'sml', 'snnsnet',
    \ 'snnspat', 'snnsres', 'snobol4', 'spec', 'specman', 'spice', 'splint', 'spup',
    \ 'spyce', 'sql', 'sqlanywhere', 'sqlforms', 'sqlhana', 'sqlinformix', 'sqlj',
    \ 'sqloracle', 'sqr', 'squid', 'srec', 'sshconfig', 'sshdconfig', 'st', 'stata',
    \ 'stp', 'strace', 'sudoers', 'svg', 'svn', 'swift', 'swiftgyb', 'syncolor',
    \ 'synload', 'syntax', 'sysctl', 'systemd', 'systemverilog', 'tads', 'tags',
    \ 'tak', 'takcmp' , 'takout', 'tap', 'tar', 'taskdata', 'taskedit', 'tasm', 'tcl',
    \ 'tcsh', 'template', 'teraterm', 'terminfo', 'tex', 'texinfo', 'texmf', 'text',
    \ 'tf', 'tidy', 'tilde', 'tli', 'tmux', 'tpp', 'trasy s', 'treetop', 'trustees',
    \ 'tsalt', 'tsscl', 'tssgm', 'tssop', 'tt2', 'tt2html', 'tt2js', 'typescript',
    \ 'typescriptcommon', 'typescriptreact', 'uc', 'udevconf', 'udevperm',
    \ 'udevrules', 'uil', 'u pdatedb', 'upstart', 'upstreamdat', 'upstreaminstalllog',
    \ 'upstreamlog', 'upstreamrpt', 'usserverlog', 'usw2kagtlog', 'valgrind', 'vb',
    \ 'vera', 'verilog', 'verilogams', 'vgrindefs', 'vhdl', 'vim' , 'viminfo',
    \ 'virata', 'vmasm', 'voscm', 'vrml', 'vroom', 'vsejcl', 'vue', 'wast', 'wdiff',
    \ 'web', 'webmacro', 'wget', 'whitespace', 'winbatch', 'wml', 'wsh', 'wsml',
    \ 'wvdial', 'xbl', 'xdefaults' , 'xf86conf', 'xhtml', 'xinetd', 'xkb', 'xmath',
    \ 'xml', 'xmodmap', 'xpm', 'xpm2', 'xquery', 'xs', 'xsd', 'xslt', 'xxd', 'yacc',
    \ 'yaml', 'z8a', 'zimbu', 'zsh'
    \ ]

let s:utils = [
            \ 'find', 'xargs', 'chmod',
            \ 'sed', 'grep', 'awk',
            \ 'rm', 'cp', 'mv', 'mkdir', 'ls',
            \ 'tar', 'unrar', 'unzip', '7z',
            \ 'cron', 'at', 'batch',
            \ 'lsblk', 'mkfs', 'chroot', 'chown', 'chmod', 'umask',
            \ 'userdel', 'adduser', 'deluser', 'useradd', 'groupadd', 'chsh',
            \ 'ffmpeg', 'youtube-dl', 'mpv',
            \ 'systemd', 'runit',
            \ 'xinit', 'startx',
            \ 'git',
            \]
" g:cheat#list is a custom list provided by the user
let s:list = g:cheat#languages + g:cheat#utils + s:languages + s:utils
" Remove any duplicates (source: https://stackoverflow.com/a/6630950/13041067)
let s:unduplist=filter(copy(s:list), 'index(s:list, v:val, v:key+1)==-1')

" Remove trailing white spaces
function! cheat#tidy() abort
    let _s=@/
    silent! %s/\s\+$//e
    " Suppress the 'Hit enter to continue' message
    redraw!
    let @/=_s
    nohl
endfunction

function! cheat#queryLanguages(A, L, P) abort
    " Note that in order to have the completion list intact you must copy it
    " instead of changing it
    " source: https://dev.to/pbnj/how-to-get-make-target-tab-completion-in-vim-4mj1
    return filter(copy(s:unduplist), 'v:val =~ "^' . a:A . '"')
endfunction

function! cheat#cheat() abort
    " Prompt the user for a language or a tool
    echoh Question
    let l:selected = join(split(input('lang/tool> ', "", "customlist,cheat#queryLanguages")), '+')
    " Check if the user chosed an item
    if empty(l:selected) != 0
        return
    endif
    let l:query = join(split(input('query> ')), '+')
    echoh None

    " Construct the url
    if l:query ==# ""
        " If no query provided
        let l:url = 'cht.sh/' . l:selected
    else
        if index(s:unduplist, l:selected, v:true) == '-1'
            " Utility
            let l:url = 'cht.sh/' . l:selected . '~' . l:query
        else
            " Language
            let l:url = 'cht.sh/' . l:selected . '/' . l:query
        endif
    endif
    " Construct the curl command
    let l:command = 'curl -s -c /tmp/somefileforcurlcookies ' . l:url

    " Grab the output of curl and put into a variable
    let l:content = system('curl -s' . l:command . '| sed ''s/\x1b\[[0-9;]*[a-zA-Z]//g''' )

    " Remove the cookie jar
    call system('rm /tmp/somefileforcurlcookies')

    " After downloading text, create a new scratch buffer in a new tab
    if &buftype ==# 'nofile'
        enew
    else
        tabnew
    endif
    setlocal
                \ bufhidden=wipe
                \ buftype=nofile
                \ nobuflisted
                \ nolist
                \ noswapfile
                \ norelativenumber
                \ nonumber
                \ signcolumn=no
    " To quit this window only press q
    nnoremap <buffer><silent> q :bd<CR>

    " Dump the final content in the buffer
    -1 put =l:content

    " If a language then enable syntax highlighting for that language otherwise
    " set the filetype to shell
    if index(s:languages + g:cheat#languages, l:selected, v:true) == '-1'
        setlocal filetype=sh
    else
        exec ':setlocal filetype='. l:selected
    endif

    " Make this buffer Readonly
    setlocal readonly nomodifiable nomodified

    call cheat#tidy()

    " Immediately go to the top of the buffer
    norm gg
endfunction
