(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
    (car (cdr s))
)

(define (caddr s)
    (car (cdr (cdr s)))
)


(define (sign num)
    (cond 
        ((< num 0) -1)
        ((> num 0) 1)
        (else 0)
    )
)


(define (square x) (* x x))

(define (pow x y)
    (cond
        ((= y 0) 1)
        ((odd? y) (* x (pow x (- y 1))))
        (else (square (pow x (/ y 2))))
    )
)


(define (unique s)
    (if (null? s)
        nil
        (cons 
            (car s)
            (unique 
                (filter 
                    (lambda (x) (not (equal? (car s) x)))
                    s
                )
            )
        )
    )
)


(define (replicate x n)
    (define (helper n ans)
        (if (= n 0)
            ans
            (helper
                (- n 1)
                (cons x ans)
            )
        )
    )
    (helper n nil)
)


(define (accumulate combiner start n term)
    (define (helper cnt ans)
        (if (= cnt (+ n 1))
            ans
            (helper
                (+ 1 cnt)
                (combiner
                    ans
                    (term cnt)
                )
            )
        )
    )
    (helper 1 start)
)


(define (accumulate-tail combiner start n term)
    (define (helper cnt ans)
        (if (= cnt (+ n 1))
            ans
            (helper
                (+ 1 cnt)
                (combiner
                    ans
                    (term cnt)
                )
            )
        )
    )
    (helper 1 start)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
    (list 'map
        (list 'lambda (list var) map-expr)
        (list 'filter
            (list 'lambda (list var) filter-expr)
            lst
        )
    )
)

