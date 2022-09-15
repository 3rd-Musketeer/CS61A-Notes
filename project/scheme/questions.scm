(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
    (map (lambda (y) (cons first y)) rests)
)

(define (zip pairs)
  'replace-this-line)

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
    (define (helper s n)
        (if (null? s)
            nil
            (cons (list n (car s)) (helper (cdr s) (+ n 1)))
        )
    )
    (helper s 0)
)
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
    (if (= 0 total) 
        (list nil)
        (begin
            (define res nil)
            (if (>= total (car denoms)) (define res (append res (cons-all (car denoms) (list-change (- total (car denoms)) denoms)))))
            (if (not (null? (cdr denoms))) (define res (append res (list-change total (cdr denoms)))))
            res
        )
    )
)
  ; END PROBLEM 17
  
;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

(define (unzip pairs)
    (define (helper s k v)
        (if (null? s)
        (list k v)
        (helper
            (cdr s)
            (append k (list (caar s)))
            (append v (list (car (cdar s)))))
        )
    )
    (helper pairs nil nil)
)

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (cons form (cons params (map let-to-lambda body)))
           ; END PROBLEM 18
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (define kv (unzip values))
           (append (list (cons 'lambda (cons (car kv) (map let-to-lambda body)))) (map let-to-lambda (cadr kv)))
           ; END PROBLEM 18
           ))
        (else
         ; BEGIN PROBLEM 18
         (cons (car expr) (map let-to-lambda (cdr expr)))
         ; END PROBLEM 18
         )))