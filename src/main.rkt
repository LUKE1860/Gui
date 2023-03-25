#lang racket/gui
(require mrlib/path-dialog)
;main core of the program
(define frame (new frame% [label "Racketpad"][min-width 1920][min-height 1080]))
;defines text buffer
(define text (new text% [tab-stops null]))
;path dialog for creating a file
(define new-path-dialog (new path-dialog% [label "Create a file"][new? #t] [existing? #f]))
;path dialog for opening a file
(define open-path-dialog (new path-dialog% [label "Open a file"]))
;path for saving a file
(define path "")
;function for saving a file
(define (file_save file text)
(let ([writer (open-output-file file #:mode 'binary #:exists 'truncate)])
(display text writer)
(close-output-port writer)))
;opens and reads a file contents to string
(define (file_open file)(set! path file)(port->string(open-input-file file)#:close? #t))
;editor-canvas with frame parent and text attached to editor
(new editor-canvas% [parent frame][editor text])
;defines menu-bar
(define menu-bar (new menu-bar% [parent frame]))
;defines menu File
(define menu (new menu%
[label "&File"]
[parent menu-bar]))
;definitions of menu-items
(new menu-item% [label "&New"][parent menu][callback (lambda(_menu-item _event)(set! path (send new-path-dialog run))(open-output-file path)(send text insert (file_open path)))])
(new menu-item% [label "&Open"][parent menu][callback (lambda(_menu-item _event)(send text erase)(send text insert (file_open (send open-path-dialog run ))))])
(new menu-item% [label "&Save"][parent menu][callback (lambda(_menu-item _event)(file_save path (send text get-text 0 'eof)))])
(send menu-bar enable #t) 
(send frame show #t)