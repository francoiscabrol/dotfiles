" Vim syntax file
" Language:   Kiwi
" Maintainer: Sébastien Pierre <sebastien@type-z.org>
" Updated:    2006-07-07

syn match kiwiComment			"^#.*$"
syn match kiwiTitle				"^== [^=]\+.\+$"
syn match kiwiSubTitle			/^-- .*$/
syn match kiwiPreformatted		/\s*>\(\t\|   \).*/
syn match kiwiBold				/\*.*\*/
syn match kiwiCode				/`.*`/
syn match kiwiKeyword			/_.*_/
syn match kiwiLink				/\[.*\]\s*([^\)]*)/
syn match kiwiListItem			/^\s*\(-\|\a)\|\d)\)\s*[^:.,]*/

syn match kiwiSectionSingle		/^\(\d\.\)+\d?.*$/
syn match kiwiSectionMulti 		/^.*\n\(=\+\|-\+\)$/

hi def link kiwiTitle			Function
hi def link kiwiComment			Comment

hi def link kiwiSectionSingle	Function
hi def link kiwiSectionMulti	Function

hi def link kiwiListItem		Special

hi def link kiwiLink			Statement
hi def link kiwiEmail			Statement
hi def link kiwiKeyword			Statement

hi def link kiwiPreformatted	String
hi def link kiwiCode			String
hi def link kiwiBold			String

