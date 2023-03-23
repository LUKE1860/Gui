#lang racket/gui
(require mrlib/path-dialog)
(define text (new text% [tab-stops null]))
;path dialog for opening a file
(define open-path-dialog (new path-dialog% [label "Open a file"]))
;opens and reads a file contents to string
(define (file_open file)(println (port->string(open-input-file file)#:close? #t)))
;main core of the program
(define frame (new frame% [label "Racketpad"][min-width 1920][min-height 1920]))
;defines editor area
(define editor-area (new editor-canvas% [parent frame][editor text]))
;defines menu-bar
(define menu-bar (new menu-bar% [parent frame]))
;defines menu File
(define menu (new menu%
[label "&File"]
[parent menu-bar]))
;definitions of menu-items
(new menu-item% [label "&New"][parent menu][callback (lambda(menu-item event)(println "No"))])
(new menu-item% [label "&Open"][parent menu][callback (lambda(menu-item event)(file_open (send open-path-dialog run)))])
(new menu-item% [label "&Save"][parent menu][callback (lambda(menu-item event)(println "No"))])
(new menu-item% [label "&Save as"][parent menu][callback (lambda(menu-item event)(println "No"))])
(send menu-bar enable #t)
(send frame show #t)