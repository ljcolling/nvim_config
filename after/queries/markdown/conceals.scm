(( fenced_code_block_delimiter) @delim (#set! conceal " \n"))

((fenced_code_block (info_string (language) @id (#match? @id "r"))) (#set! conceal "R"))


 ((paragraph (inline (inline_link (link_text) @link))) (#set! conceal = ""))

 ((fenced_code_block (fenced_code_block_delimiter) @capture) (#set! conceal "R"))

